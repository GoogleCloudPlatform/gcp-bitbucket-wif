# Terraform Google Cloud Project Factory with Workload Identity Federation (WIF)

## Overview

This Terraform configuration is designed to set up a Google Cloud project with Workload Identity Federation. The primary goal is to enable the use of Workload Identity federation within Bitbucket for seamless and secure cloud infrastructure management. It leverages the `terraform-google-modules/project-factory/google` module for project creation and sets up the necessary resources and IAM roles for integrating Bitbucket with Google Cloud using WIF.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install)
- A Google Cloud account with billing set up
- A Bitbucket Workspace with pipelines enabled for OIDC configuration

## APIs

In order to operate the Project Factory, you must activate the following APIs on
the base project where the Service Account was created:

- Cloud Resource Manager API - `cloudresourcemanager.googleapis.com`
- Cloud Billing API - `cloudbilling.googleapis.com`
- Identity and Access Management API - `iam.googleapis.com`
- Admin SDK - `admin.googleapis.com`

## Created Resources

- **Project**: Automatically creates a new Google Cloud project to host Workload Identity resources
- **Workload Identity Pool and Provider**: Sets up a workload identity pool and provider for Bitbucket.
- **Service Account Creation**: Creates a Google service account with specific roles for WIF. This Service Account will be used to deploy GCP resources through Bitbucket 
- **IAM Role Bindings**: Configures necessary IAM roles and binds them to the service account.
- **Terraform Outputs**: Provides essential information for OIDC configuration.

## Usage

1. **Repository Cloning**: Start by navigating to Cloud Shell or to a working directory with Terraform and cloning this repo from GitHub.


2. **Initialize Variables**: Set up the required variables in a `.tfvars` file or directly in the Terraform configuration.
   - `bitbucket_workspace`: Your Bitbucket workspace.
   - `allowed_audiences`: Allowed audiences for OIDC.
   - `sa-roles`: Roles to be assigned to the service account.
   - `project_name`, `org_id`, `parent`, `billing_account`: GCP specific variables.
   - `backend_bucket_name`: Bucket name for Terraform state.

3. **Terraform Commands**: Use standard Terraform commands to initialize, plan, and apply your configuration.
   - `terraform init`
   - `terraform plan`
   - `terraform apply`

4. **Bitbucket Configuration**: Using the outputted variables from the Terraform commands, configure your Bitbucket workspace to use the Workload Identity Provider. An example to deploy a simple GCS bucket can be found in the [Bitbucket folder](./Bitbucket/).
    1. Clone this repository and push it to your own Bitbucket repository.
    2. Enable pipelines in your Bitbucket Repository. This is done in **Repository Settings** > **Pipelines** > **Settings**.
    3. Set up the required environment variables in your Bitbucket repository settings. This is done in **Repository Settings** > **Pipelines** > **Repository variables**.

        | Environment Variable            | Description                                                                       | Example Value                                               |
        |---------------------------------|-----------------------------------------------------------------------------------|-------------------------------------------------------------|
        | `TERRAFORM_VERSION`             | The version of Terraform you want to use                                          | `1.4.2`                                                     |
        | `STATE_BUCKET`                  | The Google Cloud Storage bucket where your Terraform state files will be stored   | `my-terraform-state-bucket`                                 |
        | `GCP_WORKLOAD_IDENTITY_PROVIDER`| The fully qualified identifier of your Google Cloud Workload Identity Provider    | `projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/POOL_ID/providers/PROVIDER_ID` |
        | `GCP_SERVICE_ACCOUNT`           | The email address of your Google Cloud Service Account                            | `my-service-account@my-project.iam.gserviceaccount.com`     |
        | `PROJECT_NAME`                  | Your Google Cloud project ID                                                      | `my-gcp-project`                                            |
    4. Commit to your repository or manually trigger the pipeline.



## Notes

- Ensure you have appropriate permissions in your Google Cloud and Bitbucket accounts.
- Review and adjust IAM roles according to your specific security and operational requirements.
- The configuration is licensed under the Apache License, Version 2.0.

## Disclaimer

This configuration is provided "as is" without any warranties or conditions. Use it at your own risk.

## License

Copyright 2022 Google LLC

Licensed under the Apache License, Version 2.0. See LICENSE for details.
