# Allow VPC local traffic into endpoints via HTTPS
resource "aws_vpc_security_group_ingress_rule" "local_in_endpoint" {
  for_each = toset(local.iep_services)

  security_group_id = aws_security_group.endpoint[each.key].id
  description       = "Allow local from ${module.vpc.vpc_id}"
  cidr_ipv4         = module.vpc.vpc_cidr_block
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
