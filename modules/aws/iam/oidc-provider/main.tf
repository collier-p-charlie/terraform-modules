locals {
  url        = var.url
  client_ids = var.client_ids
}

resource "aws_iam_openid_connect_provider" "this" {
  url            = local.url
  client_id_list = local.client_ids
}
