/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "random_id" "rand" {
  byte_length = 4
}

module "wif-project" {
  source            = "terraform-google-modules/project-factory/google"
  version           = "~> 14.4"
  name              = "${var.project_name}-${random_id.rand.hex}"
  org_id            = var.org_id
  billing_account   = var.billing_account
  folder_id         = var.parent
  create_project_sa = false
  activate_apis     = [
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
  ]
}

resource "google_iam_workload_identity_pool" "wif-pool-bitbucket" {
  workload_identity_pool_id = "bitbucket-pool-${random_id.rand.hex}"
  project                   = module.wif-project.project_id
}

resource "google_iam_workload_identity_pool_provider" "wif-provider-bitbucket" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.wif-pool-bitbucket.workload_identity_pool_id
  workload_identity_pool_provider_id = "bitbucket-provider-${random_id.rand.hex}"
  project                            = module.wif-project.project_id
  attribute_mapping = {
    "google.subject"                        = "assertion.sub"
    "attribute.sub"                         = "assertion.sub"
    "attribute.deployment_environment_uuid" = "assertion.deploymentEnvironmentUuid"
    "attribute.repository_uuid"             = "assertion.repositoryUuid"
  }
  oidc {
    issuer_uri        = "https://api.bitbucket.org/2.0/workspaces/${var.bitbucket_workspace}/pipelines-config/identity/oidc"
    allowed_audiences = var.allowed_audiences
  }
  depends_on = [
    google_iam_workload_identity_pool.wif-pool-bitbucket
  ]
}

resource "google_service_account" "sa" {
  account_id   = "bitbucket-wif-sa-${random_id.rand.hex}"
  display_name = "Bitbucket Wif Service account"
  project      = module.wif-project.project_id
}

resource "google_service_account_iam_member" "sa-iam" {
  service_account_id = google_service_account.sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.wif-pool-bitbucket.name}/attribute.repository_uuid/${var.repository_uuid}"
}

resource "google_project_iam_member" "sa-project" {
  for_each   = toset(var.sa_roles)
  role       = each.value
  member     = "serviceAccount:${google_service_account.sa.email}"
  project    = module.wif-project.project_id
  depends_on = [google_service_account.sa]
}

resource "google_storage_bucket_iam_member" "state-bucket-member" {
  bucket = var.backend_bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.sa.email}"
}