locals {
  bucket_name       = var.bucket_name
  versioning_status = var.versioning_status
  create_versioning = local.versioning_status != "Disabled"
  policy            = var.policy
  create_policy     = local.policy != null
  force_destroy     = var.force_destroy
  tags              = var.tags
}

resource "aws_s3_bucket" "this" {
  bucket        = local.bucket_name
  force_destroy = local.force_destroy

  tags = local.tags
}

resource "aws_s3_bucket_versioning" "this" {
  count  = local.create_versioning ? 1 : 0
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = local.versioning_status
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = local.create_policy ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = local.policy
}
