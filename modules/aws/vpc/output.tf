output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The identifier of the created VPC."
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "The private subnets of the VPC."
}

output "interface_endpoint_sg_ids" {
  value       = { for service, sg in aws_security_group.endpoint : service => sg.id }
  description = "A map of interface services to their respective security group."
}
