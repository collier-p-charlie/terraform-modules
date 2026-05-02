variable "name" {
  type        = string
  description = "The name of the secret"

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 512
    error_message = "name must be between 1 and 512 characters"
  }
}

variable "description" {
  type        = string
  description = "A description of the secret"
  default     = null
}

variable "recovery_window_in_days" {
  type        = number
  description = "Number of days that Secrets Manager waits before deleting the secret. Set to 0 to delete immediately"
  default     = 30

  validation {
    condition     = var.recovery_window_in_days == 0 || (var.recovery_window_in_days >= 7 && var.recovery_window_in_days <= 30)
    error_message = "recovery_window_in_days must be 0 (force delete) or between 7 and 30"
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the secret"
  default     = {}
}
