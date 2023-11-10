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

output "project_name" {
  description = "The name of the Wif project"
  value       = module.wif-project.project_name
}

output "state_bucket" {
  description = "The bucket for Terraform state"
  value       = var.backend_bucket_name
}

output "wif_provider_id_bitbucket" {
  description = "Bitbucket Workload Identity Pool"
  value       = google_iam_workload_identity_pool_provider.wif-provider-bitbucket.name
}

output "service_account_principle" {
  description = "The service account email"
  value       = google_service_account.sa.email
}
