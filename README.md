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

