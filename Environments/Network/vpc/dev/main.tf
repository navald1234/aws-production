module "aws_vpc" {
  source = "../../../../modules/Network"

  #################################################
  # ENVIRONMENT
  #################################################

  environment = var.environment

  cluster_name = var.cluster_name


  #################################################
  # PROJECT
  #################################################

  project_name = var.project_name

  #################################################
  # NETWORKING
  #################################################

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  #################################################
  # SUBNETS
  #################################################

  public_subnets = var.public_subnets

  private_subnets = var.private_subnets



}