#################################################
# LAUNCH TEMPLATE MODULE
#################################################

module "launch_template" {

  source = "../../../../Modules/compute/lt"

  #################################################
  # ENVIRONMENT
  #################################################

  environment = var.environment

  #################################################
  # PROJECT
  #################################################

  project_name = var.project_name

  #################################################
  # EC2
  #################################################

  instance_type = var.instance_type

  key_name = var.key_name

  #################################################
  # SECURITY GROUP
  #################################################
  aws_region            = var.aws_region
  ec2_security_group_id = data.terraform_remote_state.vpc_backend.outputs.ec2_security_group_id
}