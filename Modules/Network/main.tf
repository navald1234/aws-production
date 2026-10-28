locals {

  common_tags = {

    Environment = var.environment

    Project = var.project_name

    ManagedBy = var.managed_by
  }
}

module "vpc" {

  source = "./VPC"

  vpc_cidr = var.vpc_cidr

  environment = var.environment

  common_tags = local.common_tags
}

module "igw" {

  source = "./IGW"

  vpc_id = module.vpc.vpc_id

  environment = var.environment

  common_tags = local.common_tags
}

module "subnets" {

  source = "./Subnets"

  vpc_id = module.vpc.vpc_id

  environment = var.environment

  cluster_name = var.cluster_name

  availability_zones = var.availability_zones

  public_subnets = var.public_subnets

  private_subnets = var.private_subnets

  common_tags = local.common_tags
}

module "nat" {

  source = "./Nat"

  environment = var.environment

  igw_id = module.igw.igw_id

  public_subnet_ids = module.subnets.public_subnet_ids

  depends_on = [module.igw]

  common_tags = local.common_tags
}

module "route_tables" {

  source = "./Route-Tables"

  vpc_id = module.vpc.vpc_id

  igw_id = module.igw.igw_id

  nat_gateway_ids = module.nat.nat_gateway_ids

  public_subnet_ids = module.subnets.public_subnet_ids

  private_subnet_ids = module.subnets.private_subnet_ids
}

module "security_groups" {

  source = "./security-groups"

  vpc_id = module.vpc.vpc_id

  environment = var.environment
  project_name = var.project_name
}

# module "endpoints" {

#   source = "./endpoints"

#   vpc_id = module.vpc.vpc_id

#   private_subnet_ids = module.subnets.private_subnet_ids

#   private_route_table_ids = module.route_tables.private_route_table_ids

#   endpoint_security_group_id = module.security_groups.vpce_sg_id

#   aws_region = var.aws_region

#   common_tags = local.common_tags
# }