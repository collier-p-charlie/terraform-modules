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
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_ids"></a> [client\_ids](#input\_client\_ids) | The list of client IDs / audiences for the OIDC provider. | `list(string)` | n/a | yes |
| <a name="input_command_role_arn"></a> [command\_role\_arn](#input\_command\_role\_arn) | The AWS IAM role to assume for resource creation; required for cross-account deployments. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project identifier. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region name. | `string` | `"eu-west-2"` | no |
| <a name="input_url"></a> [url](#input\_url) | The URL of the OIDC provider. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_provider_arn"></a> [provider\_arn](#output\_provider\_arn) | The ARN of the created OIDC provider. |
<!-- END_TF_DOCS -->
