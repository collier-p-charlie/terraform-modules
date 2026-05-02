variable "name" {
  type        = string
  description = "The name of the SNS topic. Do not include the '.fifo' suffix — it is appended automatically when fifo_topic is true"

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 256
    error_message = "name must be between 1 and 256 characters"
  }

  validation {
    condition     = !endswith(var.name, ".fifo")
    error_message = "name must not include the '.fifo' suffix — it is appended automatically when fifo_topic is true"
  }
}

variable "fifo_topic" {
  type        = bool
  description = "Whether to create a FIFO topic. The '.fifo' suffix is automatically appended to the topic name when enabled"
  default     = false
}

variable "content_based_deduplication" {
  type        = bool
  description = "Whether to enable content-based deduplication. Only valid for FIFO topics"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the SNS topic"
  default     = {}
}
