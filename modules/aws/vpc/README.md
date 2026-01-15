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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | ~> 3.11 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_ingress_rule.local_in_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone_ids"></a> [availability\_zone\_ids](#input\_availability\_zone\_ids) | The list of availability zone IDs the VPC should span. | `list(string)` | n/a | yes |
| <a name="input_command_role_arn"></a> [command\_role\_arn](#input\_command\_role\_arn) | The AWS IAM role to assume for resource creation; required for cross-account deployments. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name. | `string` | n/a | yes |
| <a name="input_gateway_endpoint_services"></a> [gateway\_endpoint\_services](#input\_gateway\_endpoint\_services) | A list of service names to create gateway endpoints for. | `list(string)` | <pre>[<br/>  "s3",<br/>  "dynamodb"<br/>]</pre> | no |
| <a name="input_interface_endpoint_services"></a> [interface\_endpoint\_services](#input\_interface\_endpoint\_services) | A list of service names to create interface endpoints for. | `list(string)` | `[]` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix to append to all resources created in this module. | `string` | n/a | yes |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | The list of CIDR blocks for private subnets. | `list(string)` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project identifier. | `string` | n/a | yes |
| <a name="input_public_subnets_cidr"></a> [public\_subnets\_cidr](#input\_public\_subnets\_cidr) | The list of CIDR blocks for public subnets. | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region name. | `string` | `"eu-west-2"` | no |
| <a name="input_single_nat"></a> [single\_nat](#input\_single\_nat) | Whether to construct one NAT in a single AZ or one per AZ. | `bool` | `true` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_interface_endpoint_sg_ids"></a> [interface\_endpoint\_sg\_ids](#output\_interface\_endpoint\_sg\_ids) | A map of interface services to their respective security group. |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | The private subnets of the VPC. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The identifier of the created VPC. |
<!-- END_TF_DOCS -->
