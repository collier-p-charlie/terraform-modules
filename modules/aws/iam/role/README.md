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
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command_role_arn"></a> [command\_role\_arn](#input\_command\_role\_arn) | The AWS IAM role to assume for resource creation; required for cross-account deployments. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A description of the IAM role and its permissions. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name. | `string` | n/a | yes |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | The sts:ExternalId value for the trust policy condition. | `string` | `null` | no |
| <a name="input_managed_policies"></a> [managed\_policies](#input\_managed\_policies) | A list of any AWS managed policies to attach to the role. | `list(string)` | `[]` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | A JSON-encoded string containing an IAM policy document. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project identifier. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region name. | `string` | `"eu-west-2"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name for the AWS IAM role to create. | `string` | n/a | yes |
| <a name="input_trust_policy"></a> [trust\_policy](#input\_trust\_policy) | A JSON-encoded string containing an IAM policy document.<br/>    If specified, this will override any ARNs specified in the `trusted_arns` parameter.<br/>    In other words, it will ignore the `trusted_arns` and `external_id` parameter inputs.<br/>    If neither are specified, then it will result to default account root access. | `string` | `null` | no |
| <a name="input_trusted_arns"></a> [trusted\_arns](#input\_trusted\_arns) | The AWS IAM role ARNs for the trust policy of the created integration role. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The ARN of the created IAM role. |
<!-- END_TF_DOCS -->
