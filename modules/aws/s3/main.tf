locals {
  bucket_name       = var.bucket_name
  versioning_status = var.versioning_enabled ? "Enabled" : "Suspended"
  force_destroy     = var.force_destroy
  tags              = var.tags
}

resource "aws_s3_bucket" "this" {
  bucket        = local.bucket_name
  force_destroy = local.force_destroy

  tags = local.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = local.versioning_status
  }
}
