output "provider_arn" {
  value       = aws_iam_openid_connect_provider.this.arn
  description = "The ARN of the created OIDC provider."
}
