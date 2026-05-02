variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "bucket_name must be between 3 and 63 characters"
  }

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9\\-\\.]*[a-z0-9]$", var.bucket_name))
    error_message = "bucket_name must start and end with a lowercase letter or number, and contain only lowercase letters, numbers, hyphens, or dots"
  }
}

variable "versioning_enabled" {
  type        = bool
  description = "Whether to enable versioning on the S3 bucket"
  default     = false
}

variable "force_destroy" {
  type        = bool
  description = "Whether to allow the bucket to be destroyed even if it contains objects"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the S3 bucket"
  default     = {}
}
