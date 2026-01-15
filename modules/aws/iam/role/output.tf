output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "The ARN of the created IAM role."
}
