# Terraform Google Cloud Project Factory with Workload Identity Federation (WIF)

## Overview

This Terraform configuration is designed to set up a Google Cloud project with Workload Identity Federation. The primary goal is to enable the use of Workload Identity federation within Bitbucket for seamless and secure cloud infrastructure management. It leverages the `terraform-google-modules/project-factory/google` module for project creation and sets up necessary resources and IAM roles for integrating Bitbucket with Google Cloud using WIF.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install)
- A Google Cloud account with billing set up
- A Bitbucket Workspace for OIDC configuration

## APIs

In order to operate the Project Factory, you must activate the following APIs on
the base project where the Service Account was created:

- Cloud Resource Manager API - `cloudresourcemanager.googleapis.com`
  [troubleshooting](docs/TROUBLESHOOTING.md#missing-api-cloudresourcemanagergoogleapiscom)
- Cloud Billing API - `cloudbilling.googleapis.com`
  [troubleshooting](docs/TROUBLESHOOTING.md#missing-api-cloudbillinggoogleapiscom)
- Identity and Access Management API - `iam.googleapis.com`
  [troubleshooting](docs/TROUBLESHOOTING.md#missing-api-iamgoogleapiscom)
- Admin SDK - `admin.googleapis.com`
  [troubleshooting](docs/TROUBLESHOOTING.md#missing-api-admingoogleapiscom)

## Created Resources

- **Project**: Automatically creates a new Google Cloud project to host Workload Identity resources
- **Workload Identity Pool and Provider**: Sets up a workload identity pool and provider for Bitbucket.
- **Service Account Creation**: Creates a Google service account with specific roles for WIF. This Service Account will be used to deploy other GCP resources. 
- **IAM Role Bindings**: Configures necessary IAM roles and binds them to the service account.
- **Terraform Outputs**: Provides essential information for OIDC configuration.

## Usage

1. **Initialize Variables**: Set up the required variables in a `.tfvars` file or directly in the Terraform configuration.
   - `bitbucket_workspace`: Your Bitbucket workspace.
   - `allowed_audiences`: Allowed audiences for OIDC.
   - `sa-roles`: Roles to be assigned to the service account.
   - `project_name`, `org_id`, `parent`, `billing_account`: Project setup variables.
   - `repository_uuid`: Bitbucket repository UUID.
   - `backend_bucket_name`: Bucket name for Terraform state.

2. **Terraform Commands**: Use standard Terraform commands to initialize, plan, and apply your configuration.
   - `terraform init`
   - `terraform plan`
   - `terraform apply`

## Notes

- Ensure you have appropriate permissions in your Google Cloud and Bitbucket accounts.
- Review and adjust IAM roles according to your specific security and operational requirements.
- The configuration is licensed under the Apache License, Version 2.0.

## Disclaimer

This configuration is provided "as is" without any warranties or conditions. Use it at your own risk.

## License

Copyright 2022 Google LLC

Licensed under the Apache License, Version 2.0. See LICENSE for details.
