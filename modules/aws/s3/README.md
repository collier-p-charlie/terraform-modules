<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.14.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.27 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.27 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_notification.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_object_lock_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket to create. | `string` | n/a | yes |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | A JSON-encoded IAM policy document for the bucket resource policy. | `string` | `null` | no |
| <a name="input_command_role_arn"></a> [command\_role\_arn](#input\_command\_role\_arn) | The AWS IAM role to assume for resource creation; required for cross-account deployments. | `string` | n/a | yes |
| <a name="input_compliance_days"></a> [compliance\_days](#input\_compliance\_days) | The number of days to retain objects under object lock in compliance mode. | `number` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name. | `string` | n/a | yes |
| <a name="input_files_to_upload"></a> [files\_to\_upload](#input\_files\_to\_upload) | Map of S3 object keys (keys) from the corresponding local files (values) to upload. | `map(string)` | `{}` | no |
| <a name="input_governance_days"></a> [governance\_days](#input\_governance\_days) | The number of days to retain objects under object lock in governance mode. | `number` | `null` | no |
| <a name="input_notification_config"></a> [notification\_config](#input\_notification\_config) | List of notification configuration rules mapping S3 objects to targets. | <pre>list(object({<br/>    type       = string<br/>    target_arn = string<br/>    prefix     = string<br/>    suffix     = optional(string)<br/>    id         = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project identifier. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region name. | `string` | `"eu-west-2"` | no |
| <a name="input_versioned"></a> [versioned](#input\_versioned) | Whether the S3 bucket has versioning enabled or not. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the created bucket. |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the bucket created. |
<!-- END_TF_DOCS -->
