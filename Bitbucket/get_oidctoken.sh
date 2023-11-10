#!/bin/bash

# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e
echo ${BITBUCKET_STEP_OIDC_TOKEN} > /tmp/gcp_access_token.out
gcloud iam workload-identity-pools create-cred-config ${GCP_WORKLOAD_IDENTITY_PROVIDER} --service-account="${GCP_SERVICE_ACCOUNT}" --output-file=.gcp_temp_cred.json --credential-source-file=/tmp/gcp_access_token.out
gcloud auth login --cred-file=`pwd`/.gcp_temp_cred.json
gcloud projects list
gcloud config set project $PROJECT_NAME
export GOOGLE_APPLICATION_CREDENTIALS=`pwd`/.gcp_temp_cred.json