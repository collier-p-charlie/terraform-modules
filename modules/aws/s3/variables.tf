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

variable "versioning_status" {
  type        = string
  description = "Versioning state of the bucket: 'Enabled', 'Suspended' (only valid on existing buckets that previously had versioning enabled), or 'Disabled'"
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Suspended", "Disabled"], var.versioning_status)
    error_message = "versioning_status must be one of: Enabled, Suspended, Disabled"
  }
}

variable "force_destroy" {
  type        = bool
  description = "Whether to allow the bucket to be destroyed even if it contains objects"
  default     = false
}

variable "policy" {
  type        = string
  description = "JSON-encoded resource policy to attach to the bucket. Policy encoding should be handled in the calling module"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the S3 bucket"
  default     = {}
}
