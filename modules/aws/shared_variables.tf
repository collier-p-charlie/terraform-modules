variable "project_id" {
  type        = string
  description = "The project identifier."
}

variable "environment" {
  type        = string
  description = "The environment name."
}

variable "region" {
  type        = string
  description = "The AWS region name."
  default     = "eu-west-2"
}

variable "command_role_arn" {
  type        = string
  description = "The AWS IAM role to assume for resource creation; required for cross-account deployments."
}
