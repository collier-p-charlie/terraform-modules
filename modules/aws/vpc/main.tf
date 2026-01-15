locals {
  prefix = var.name_prefix

  vpc_cidr     = var.vpc_cidr
  az_ids       = var.availability_zone_ids
  public_cidr  = var.public_subnets_cidr
  private_cidr = var.private_subnets_cidr

  single_nat = var.single_nat

  iep_services = var.interface_endpoint_services
  gep_services = var.gateway_endpoint_services
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "${local.prefix}-vpc"
  cidr = local.vpc_cidr
  azs  = local.az_ids

  public_subnets  = local.public_cidr
  private_subnets = local.private_cidr

  create_igw = true

  enable_nat_gateway     = true
  single_nat_gateway     = local.single_nat
  one_nat_gateway_per_az = !local.single_nat
}
