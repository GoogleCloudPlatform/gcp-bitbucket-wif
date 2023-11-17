# Example Bitbucket Repository for GCP Workload Identity Federation

## Overview

This repository contains an example Bitbucket pipeline and Terraform configuration that utilizes Workload Identity Federation (WIF) established in previous steps to authenticate and deploy a simple Google Cloud Storage (GCS) bucket. This setup demonstrates how to leverage WIF for cloud operations within a CI/CD pipeline in Bitbucket.

## Files Description

- **bitbucket-pipelines.yml**: Defines the Bitbucket pipeline configuration. It includes steps for setting up Terraform, authenticating using the GCP service account through WIF, and deploying resources using Terraform.

- **get_oidctoken.sh**: A shell script that retrieves an OIDC token for authenticating with GCP services. It is used within the pipeline to establish a secure connection to GCP.

- **main.tf**: The main Terraform configuration file for defining the GCS bucket to be deployed.

- **provider.tf**: Specifies the Terraform provider configuration, particularly for GCP.

- **variables.tf**: Declares variables used in the Terraform configuration. This adds flexibility and modularity to the Terraform setup.

## Prerequisites

- A Google Cloud Platform (GCP) project with the Bitbucket WIF project deployed
- A Bitbucket workspace with a repository for CI/CD operations.

## Repository Configuration

1. Clone this repository and push it to your own Bitbucket repository.
1. Enable pipelines in your Bitbucket Repository. This is done in **Repository Settings** > **Pipelines** > **Settings**.
2. Set up the required environment variables in your Bitbucket repository settings. This is done in **Repository Settings** > **Pipelines** > **Repository variables**.

   | Environment Variable            | Description                                                                       | Example Value                                               |
   |---------------------------------|-----------------------------------------------------------------------------------|-------------------------------------------------------------|
   | `TERRAFORM_VERSION`             | The version of Terraform you want to use                                          | `1.4.2`                                                   |
   | `STATE_BUCKET`                   | The Google Cloud Storage bucket where your Terraform state files will be stored | `my-terraform-state-bucket`                              |
   | `GCP_WORKLOAD_IDENTITY_PROVIDER`| The fully qualified identifier of your Google Cloud Workload Identity Provider | `projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL_ID/providers/PROVIDER_ID` |
   | `GCP_SERVICE_ACCOUNT`           | The email address of your Google Cloud Service Account | `my-service-account@my-project.iam.gserviceaccount.com` |
   | `PROJECT_NAME`                  | Your Google Cloud project ID | `my-gcp-project`                                             |
3. Commit to your repository or manually trigger the pipeline.

## Contributing

Contributions to improve this example or extend its capabilities are welcome. Please follow standard practices for pull requests and coding conventions.

## License

This project and its contents are licensed under the Apache License, Version 2.0. Refer to the LICENSE comments in each file for more details.
