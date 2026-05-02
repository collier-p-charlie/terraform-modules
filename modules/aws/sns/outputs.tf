output "topic_arn" {
  value       = aws_sns_topic.this.arn
  description = "The ARN of the SNS topic"
}

output "topic_id" {
  value       = aws_sns_topic.this.id
  description = "The ID of the SNS topic"
}
