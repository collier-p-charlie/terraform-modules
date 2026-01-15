variable "role_name" {
  type        = string
  description = "The name for the AWS IAM role to create."
}

variable "description" {
  type        = string
  description = "A description of the IAM role and its permissions."
}

variable "permissions" {
  type        = string
  description = "A JSON-encoded string containing an IAM policy document."
  default     = null
}

variable "managed_policies" {
  type        = list(string)
  description = "A list of any AWS managed policies to attach to the role."
  default     = []
}

variable "trusted_arns" {
  type        = list(string)
  description = "The AWS IAM role ARNs for the trust policy of the created integration role."
  default     = null
}

variable "trust_policy" {
  type        = string
  description = <<EOF
    A JSON-encoded string containing an IAM policy document.
    If specified, this will override any ARNs specified in the `trusted_arns` parameter.
    In other words, it will ignore the `trusted_arns` and `external_id` parameter inputs.
    If neither are specified, then it will result to default account root access.
  EOF
  default     = null
}

variable "external_id" {
  type        = string
  description = "The sts:ExternalId value for the trust policy condition."
  default     = null
}
