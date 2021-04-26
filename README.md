# tf-gcp-gke-config-module

## Module Overview

Terraform module for installing and configuring Config Sync to apply manifests to a private GKE cluster on the Google Cloud Platform (GCP).

It deploys the following resources into a given GCP project:

- Creates Config Sync Config file
- Creates IAP tunnel to forward proxy to hit private GKE cluster
- Installs Config Sync operator
- Configures Config Sync operator to sync external git GKE manifests into cluster
- Creates GCP service account used in workload identity
- binds provided kubernetes service account with GCP service account

## Usage
Refer to the examples under [examples/](examples) directory.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.2,<0.15 |
| <a name="requirement_google"></a> [google](#requirement\_google) | <4.0,>= 2.12 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_workload-identity"></a> [workload-identity](#module\_workload-identity) | terraform-google-modules/kubernetes-engine/google//modules/workload-identity | 14.1.0 |

## Resources

| Name | Type |
|------|------|
| [local_file.config-sync-management-yaml](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.gke-config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_cluster_region"></a> [cluster\_region](#input\_cluster\_region) | Region of gke cluster | `string` | n/a | yes |
| <a name="input_forward_proxy_name"></a> [forward\_proxy\_name](#input\_forward\_proxy\_name) | Forward proxy instance name | `string` | n/a | yes |
| <a name="input_forward_proxy_zone"></a> [forward\_proxy\_zone](#input\_forward\_proxy\_zone) | Forward proxy instance zone | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID to deploy into | `string` | n/a | yes |
| <a name="input_root_manifest_folder_name"></a> [root\_manifest\_folder\_name](#input\_root\_manifest\_folder\_name) | Root folder that holds manifests | `string` | n/a | yes |
| <a name="input_secret_type"></a> [secret\_type](#input\_secret\_type) | Secret type for sync repo | `string` | `"none"` | no |
| <a name="input_service_account_description"></a> [service\_account\_description](#input\_service\_account\_description) | Service account descriptions used in workload identity | `string` | `"Service account used in workload identity"` | no |
| <a name="input_service_account_prefix"></a> [service\_account\_prefix](#input\_service\_account\_prefix) | Prefix for service accounts used in workload identity | `string` | `"gke"` | no |
| <a name="input_sync_branch"></a> [sync\_branch](#input\_sync\_branch) | Sync branch | `string` | `"master"` | no |
| <a name="input_sync_url"></a> [sync\_url](#input\_sync\_url) | Repo sync url | `string` | n/a | yes |
| <a name="input_workload_identity_service_account"></a> [workload\_identity\_service\_account](#input\_workload\_identity\_service\_account) | Service account to create in gcp for workload identity | <pre>map(object({<br>    service_account_name = string<br>    namespace = string<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
