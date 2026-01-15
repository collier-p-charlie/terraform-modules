variable "url" {
  type        = string
  description = "The URL of the OIDC provider."
}

variable "client_ids" {
  type        = list(string)
  description = "The list of client IDs / audiences for the OIDC provider."
}
