## Requirements

| Name | Version |
|------|---------|
| terraform | >=0.14.2,<0.15 |
| google | <4.0,>= 2.12 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Cluster name | `string` | `null` | no |
| cluster\_region | Region of gke cluster | `string` | `null` | no |
| forward\_proxy\_name | Forward proxy instance name | `string` | `null` | no |
| forward\_proxy\_zone | Forward proxy instance zone | `string` | `null` | no |
| project\_id | Project ID to deploy into | `string` | `null` | no |
| root\_manifest\_folder\_name | Root folder that holds manifests | `string` | `null` | no |
| secret\_type | Secret type for sync repo | `string` | `null` | no |
| sync\_branch | Sync branch | `string` | `null` | no |
| sync\_url | Repo sync url | `string` | `null` | no |

## Outputs

No output.

