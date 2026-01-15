variable "bucket_name" {
  type        = string
  description = "The name of the bucket to create."
}

variable "bucket_policy" {
  type        = string
  description = "A JSON-encoded IAM policy document for the bucket resource policy."
  default     = null
}

variable "versioned" {
  type        = bool
  description = "Whether the S3 bucket has versioning enabled or not."
  default     = true
}

variable "files_to_upload" {
  type        = map(string)
  description = "Map of S3 object keys (keys) from the corresponding local files (values) to upload."
  default     = {}
}

variable "governance_days" {
  type        = number
  description = "The number of days to retain objects under object lock in governance mode."
  default     = null
}

variable "compliance_days" {
  type        = number
  description = "The number of days to retain objects under object lock in compliance mode."
  default     = null
}

variable "notification_config" {
  type = list(object({
    type       = string
    target_arn = string
    prefix     = string
    suffix     = optional(string)
    id         = optional(string)
  }))
  description = "List of notification configuration rules mapping S3 objects to targets."
  default     = []

  validation {
    condition = alltrue([
      for rule in var.notification_config : (
        rule.type == "sqs"
      )
    ])
    error_message = "S3 bucket notification type must be one of the supported types: sqs."
  }
}
