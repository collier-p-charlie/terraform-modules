locals {
  name                        = var.fifo_topic ? "${var.name}.fifo" : var.name
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication
  tags                        = var.tags
}

resource "aws_sns_topic" "this" {
  name                        = local.name
  fifo_topic                  = local.fifo_topic
  content_based_deduplication = local.content_based_deduplication

  tags = local.tags
}
