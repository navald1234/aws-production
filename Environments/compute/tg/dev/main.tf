#################################################
# TARGET GROUP MODULE
#################################################

module "target_group" {

  source = "../../../../Modules/compute/tg"

  #################################################
  # ENVIRONMENT
  #################################################

  environment = var.environment

  #################################################
  # PROJECT
  #################################################

  project_name = var.project_name

  #################################################
  # VPC
  #################################################

  vpc_id = data.terraform_remote_state.vpc_backend.outputs.vpc_id
  aws_region = var.aws_region
}