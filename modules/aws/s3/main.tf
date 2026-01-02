locals {
  bucket_name         = var.bucket_name
  files_to_upload     = var.files_to_upload
  notification_config = var.notification_config

  notification_config_sqs = [for rule in local.notification_config : rule if rule.type == "sqs"]
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "this" {
  for_each = local.files_to_upload

  bucket = aws_s3_bucket.this.id
  key    = each.key
  source = each.value
  etag   = filemd5(each.value)
}

resource "aws_s3_bucket_notification" "this" {
  bucket = aws_s3_bucket.this.id

  dynamic "queue" {
    for_each = { for i, config in local.notification_config_sqs : i => config }

    content {
      id            = queue.value.id
      queue_arn     = queue.value.target_arn
      events        = ["s3:ObjectCreated:Put"]
      filter_prefix = queue.value.prefix
      filter_suffix = queue.value.suffix
    }
  }
}
