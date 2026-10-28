module "dns_module" {
  source = "../../Modules/Dns"
  domain_name = var.domain_name
  aws_region = var.aws_region
}