variable "name_prefix" {
  type        = string
  description = "The prefix to append to all resources created in this module."
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "CIDR block for VPC is not valid."
  }
}

variable "availability_zone_ids" {
  type        = list(string)
  description = "The list of availability zone IDs the VPC should span."
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "The list of CIDR blocks for public subnets."

  validation {
    condition     = alltrue([for cidr in var.public_subnets_cidr : can(cidrhost(cidr, 0))])
    error_message = "Some of the public subnet CIDRs are invalid."
  }
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "The list of CIDR blocks for private subnets."

  validation {
    condition     = alltrue([for cidr in var.private_subnets_cidr : can(cidrhost(cidr, 0))])
    error_message = "Some of the private subnet CIDRs are invalid."
  }
}

variable "single_nat" {
  type        = bool
  description = "Whether to construct one NAT in a single AZ or one per AZ."
  default     = true
}

variable "interface_endpoint_services" {
  type        = list(string)
  description = "A list of service names to create interface endpoints for."
  default     = []
}

variable "gateway_endpoint_services" {
  type        = list(string)
  description = "A list of service names to create gateway endpoints for."
  default     = ["s3", "dynamodb"]
}
