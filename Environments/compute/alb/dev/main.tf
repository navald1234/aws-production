#################################################
# ALB MODULE
#################################################

module "alb" {

  source = "../../../../Modules/compute/alb"

  #################################################
  # ENVIRONMENT
  #################################################

  environment = var.environment

  #################################################
  # PROJECT
  #################################################

  project_name = var.project_name

  #################################################
  # NETWORK
  #################################################

  vpc_id = data.terraform_remote_state.vpc_backend.outputs.vpc_id

  public_subnet_ids = data.terraform_remote_state.vpc_backend.outputs.public_subnet_ids

  #################################################
  # SECURITY GROUP
  #################################################

  alb_security_group_id = data.terraform_remote_state.vpc_backend.outputs.alb_security_group_id

  #################################################
  # TARGET GROUP
  #################################################

  target_group_arn = data.terraform_remote_state.tg_backend.outputs.target_group_arn

  #################################################
  # ACM CERTIFICATE
  #################################################

  acm_certificate_arn = data.terraform_remote_state.acm_backend.outputs.certificate_arn
  aws_region = var.aws_region
}