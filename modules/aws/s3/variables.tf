variable "bucket_name" {
  type        = string
  description = "The name of the bucket to create."
}

variable "files_to_upload" {
  type        = map(string)
  description = "Map of S3 object keys (keys) from the corresponding local files (values) to upload."
  default     = {}
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
