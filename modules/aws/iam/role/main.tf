locals {
  role_name        = var.role_name
  description      = var.description
  trusted_arns     = var.trusted_arns
  trust_policy     = var.trust_policy
  external_id      = var.external_id
  permissions      = var.permissions
  managed_policies = var.managed_policies

  trusted_arns_adj = (
    local.trusted_arns != null
    ? local.trusted_arns
    : ["arn:aws:iam::${local.account_id}:root"]
  )

  assume_role_policy_json = (
    local.trust_policy != null
    ? local.trust_policy
    : data.aws_iam_policy_document.trust.json
  )

  account_id = data.aws_caller_identity.this.account_id
}

data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "trust" {
  statement {
    principals {
      type        = "AWS"
      identifiers = local.trusted_arns_adj
    }
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    dynamic "condition" {
      for_each = local.external_id != null ? [1] : []

      content {
        test = "StringEquals"
        values = [
          local.external_id
        ]
        variable = "sts:ExternalId"
      }
    }
  }
}

resource "aws_iam_role" "this" {
  name               = local.role_name
  description        = local.description
  assume_role_policy = local.assume_role_policy_json
}

data "aws_iam_policy" "managed" {
  for_each = toset(local.managed_policies)
  name     = each.value
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = length(local.managed_policies) > 0 ? data.aws_iam_policy.managed : {}

  role       = aws_iam_role.this.id
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy" "this" {
  count = local.permissions != null ? 1 : 0

  name   = "inline-policy"
  role   = aws_iam_role.this.id
  policy = local.permissions
}
