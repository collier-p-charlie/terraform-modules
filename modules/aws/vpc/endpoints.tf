module "endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 3.11"

  vpc_id = module.vpc.vpc_id

  endpoints = merge(
    {
      for svc in local.gep_services : svc => {
        service         = svc
        service_type    = "Gateway"
        route_table_ids = concat(module.vpc.public_route_table_ids, module.vpc.private_route_table_ids)
        tags = {
          Name = "${local.prefix}-${svc}-ep"
        }
      }
    },
    {
      for svc in local.iep_services : svc => {
        service             = svc
        service_type        = "Interface"
        private_dns_enabled = true
        subnet_ids          = module.vpc.private_subnets
        security_group_ids  = [aws_security_group.endpoint[svc].id]
        tags = {
          Name = "${local.prefix}-${svc}-ep"
        }
      }
    }
  )
}
