# Bitbucket Workload Identity Federation

## Overview

This Terraform configuration is designed to create a Google Cloud Platform (GCP) project, establish a service account, and deploy a workload identity federation pool and provider. The primary goal is to enable the use of Workload Identity federation within Bitbucket for seamless and secure cloud infrastructure management.

## Files Description

- **main.tf**: The core Terraform file that defines the resources required for creating the GCP project and service account. It also sets up the workload identity federation pool and provider.

- **outputs.tf**: This file outlines the outputs that are generated once the Terraform scripts are successfully applied. These outputs typically include resource IDs and other critical details.

- **provider.tf**: Defines the Terraform provider configuration, in this case, specifying Google Cloud as the provider.

- **terraform.tfvars**: Contains variable values that are used throughout the Terraform configuration. This file should be configured with specific values pertinent to your GCP setup.

- **variables.tf**: Declares variables used across the Terraform configuration, ensuring modularity and flexibility of the setup.

## Prerequisites

- Terraform installed on your machine.
- Access to a Google Cloud Platform account.
- Necessary permissions to create and manage GCP resources.

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

## Usage

1. Clone this repository to your local machine.
2. Modify `terraform.tfvars` with your specific GCP project details.
3. Initialize the Terraform configuration using `terraform init`.
4. Apply the Terraform configuration using `terraform apply`.

## Contributing

This project welcomes contributions and suggestions. Feel free to fork the repository and submit pull requests.

## License

This Terraform configuration is distributed under the Apache License, Version 2.0. See the LICENSE file in each Terraform file for more details.
