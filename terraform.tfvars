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
 
org_id = "your-org-id" # Example: "123456789012"

parent = "your-parent-id" # Example: "folders/123456789012"

billing_account = "your-billing-account" # Example: "00AA11-BB22CC-DD33EE"

bitbucket_workspace = "your-bitbucket-workspace" # Example: "myworkspace"

allowed_audiences = ["your-allowed-audiences"] # Example: ["ari:cloud:bitbucket::workspace/12345678-90ab-cdef-1234-567890abcdef"]

project_name = "your-project-name" # Example: "my-project"

repository_uuid = "your-repository-uuid" # Example: "{12345678-90ab-cdef-1234-567890abcdef}"

backend_bucket_name = "your-backend-bucket-name" # Example: "my-backend-bucket"

sa_roles = [
  "roles/viewer",
  "roles/iam.serviceAccountUser",
  "roles/storage.admin",
  "roles/storage.objectAdmin",
]