resource "aws_security_group" "endpoint" {
  for_each = toset(local.iep_services)

  name        = "${local.prefix}-${each.key}-ep-sg"
  description = "Security group for the ${each.key} interface endpoint."
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${local.prefix}-${each.key}-ep-sg"
  }
}
