locals {
  name                        = var.fifo_topic ? "${var.name}.fifo" : var.name
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication
  policy                      = var.policy
  create_policy               = local.policy != null
  tags                        = var.tags
}

resource "aws_sns_topic" "this" {
  name                        = local.name
  fifo_topic                  = local.fifo_topic
  content_based_deduplication = local.content_based_deduplication

  tags = local.tags
}

resource "aws_sns_topic_policy" "this" {
  count  = local.create_policy ? 1 : 0
  arn    = aws_sns_topic.this.arn
  policy = local.policy
}
