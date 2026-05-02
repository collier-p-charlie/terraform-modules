locals {
  name                    = var.name
  description             = var.description
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = var.tags
}

resource "aws_secretsmanager_secret" "this" {
  name                    = local.name
  description             = local.description
  recovery_window_in_days = local.recovery_window_in_days

  tags = local.tags
}
