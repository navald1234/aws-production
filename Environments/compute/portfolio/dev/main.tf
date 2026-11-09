
#################################################
# portfolio MODULE
#################################################

module "portfolio" {

  source = "../../../../Modules/compute/portfolio"
  portfolio_bucket_name = var.portfolio_bucket_name
  project_name = var.project_name
  environment = var.environment
  

}