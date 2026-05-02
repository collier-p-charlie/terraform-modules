output "secret_id" {
  value       = aws_secretsmanager_secret.this.id
  description = "The ID of the secret"
}

output "secret_arn" {
  value       = aws_secretsmanager_secret.this.arn
  description = "The ARN of the secret"
}
