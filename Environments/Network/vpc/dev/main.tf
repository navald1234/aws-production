module "aws_vpc" {
  source = "../../../../modules/Network"

  # Environment
  environment  = var.environment
  cluster_name = var.cluster_name

  # Project
  project_name = var.project_name

  # Networking
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones

  # Subnets
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  # Domain / Certificate
  hosted_zone_id              = var.hosted_zone_id
  subject_alternative_names   = var.subject_alternative_names
  domain_name                 = var.domain_name

  # Tags
  common_tags = var.common_tags
}