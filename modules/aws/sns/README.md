# AWS SNS

Creates an AWS SNS topic with optional FIFO support.

When `fifo_topic` is `true`, the `.fifo` suffix is automatically appended to the topic name as required by AWS. The `name` input should not include this suffix.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.43 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.43.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | Whether to enable content-based deduplication. Only valid for FIFO topics | `bool` | `false` | no |
| <a name="input_fifo_topic"></a> [fifo\_topic](#input\_fifo\_topic) | Whether to create a FIFO topic. The '.fifo' suffix is automatically appended to the topic name when enabled | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the SNS topic. Do not include the '.fifo' suffix — it is appended automatically when fifo\_topic is true | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | JSON-encoded resource policy to attach to the SNS topic. Policy encoding should be handled in the calling module | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the SNS topic | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | The ARN of the SNS topic |
| <a name="output_topic_id"></a> [topic\_id](#output\_topic\_id) | The ID of the SNS topic |
<!-- END_TF_DOCS -->
