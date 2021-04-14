# tf-gcp-gke-config-module

## Module Overview

Terraform module for installing and configuring Config Sync to apply manifests to a private GKE cluster on the Google Cloud Platform (GCP).

It deploys the following resources into a given GCP project:

- Creates Config Sync Config file
- Creates IAP tunnel to forward proxy to hit private GKE cluster
- Installs Config Sync operator 
- Configures Config Sync operator to sync external git GKE manifests into cluster

## Usage
Refer to the examples under [examples/](examples) directory.

## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.2,<0.15 |
| google | <4.0,>= 2.12 |

## Providers

| Name | Version |
|------|---------|
| google | <4.0,>= 2.12 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Cluster name | `string` | n/a | yes |
| cluster\_region | Region of gke cluster | `string` | n/a | yes |
| forward\_proxy\_name | Forward proxy instance name | `string` | n/a | yes |
| forward\_proxy\_zone | Forward proxy instance zone | `string` | n/a | yes |
| project\_id | Project ID to deploy into | `string` | n/a | yes |
| root\_manifest\_folder\_name | Root folder that holds manifests | `string` | n/a | yes |
| secret\_type | Secret type for sync repo | `string` | `"none"` | no |
| sync\_branch | Sync branch | `string` | `"master"` | no |
| sync\_url | Repo sync url | `string` | n/a | yes |

## Outputs

No output.

