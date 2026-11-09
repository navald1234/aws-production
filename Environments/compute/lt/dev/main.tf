
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
  # AWS REGION
  #################################################

  aws_region = var.aws_region

  #################################################
  # SECURITY GROUP
  #################################################

  ec2_security_group_id = data.terraform_remote_state.vpc_backend.outputs.ec2_security_group_id

  #################################################
  # PORTFOLIO S3
  #################################################

  portfolio_bucket_name = data.terraform_remote_state.portfolio.outputs.bucket_name

  portfolio_bucket_arn = data.terraform_remote_state.portfolio.outputs.bucket_arn

  #################################################
  # IAM INSTANCE PROFILE
  #################################################

  iam_instance_profile_name = "dev-ec2-ssm-profile"

  #################################################
  # USER DATA
  #################################################

  user_data = base64encode(templatefile(
    "../../../../Modules/compute/lt/userdata.sh",
    {
      bucket_name = data.terraform_remote_state.portfolio.outputs.bucket_name
      aws_region  = var.aws_region
    }
  ))
}
