locals {
  bucket_name         = var.bucket_name
  bucket_policy       = var.bucket_policy
  versioned           = var.versioned
  files_to_upload     = var.files_to_upload
  notification_config = var.notification_config
  governance_days     = var.governance_days
  compliance_days     = var.compliance_days

  version_status          = local.versioned ? "Enabled" : "Disabled"
  notification_config_sqs = [for rule in local.notification_config : rule if rule.type == "sqs"]
  object_lock_enabled     = local.governance_days != null || local.compliance_days != null ? true : false
}

resource "aws_s3_bucket" "this" {
  bucket              = local.bucket_name
  object_lock_enabled = local.object_lock_enabled
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = local.version_status
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
  count = local.bucket_policy != null ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = local.bucket_policy
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

resource "aws_s3_bucket_object_lock_configuration" "this" {
  count = local.object_lock_enabled ? 1 : 0

  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = local.governance_days != null ? [1] : []

    content {
      default_retention {
        mode = "GOVERNANCE"
        days = local.governance_days
      }
    }
  }

  dynamic "rule" {
    for_each = local.compliance_days != null ? [1] : []

    content {
      default_retention {
        mode = "COMPLIANCE"
        days = local.compliance_days
      }
    }
  }

  lifecycle {
    precondition {
      condition     = !(local.governance_days != null && local.compliance_days != null)
      error_message = "You can only set GOVERNANCE or COMPLIANCE retention — not both."
    }
  }
}
