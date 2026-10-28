# 1. Reference your existing Route 53 Hosted Zone
data "aws_route53_zone" "main" {
  name         = var.hosted_zone_name
  private_zone = false
}


resource "aws_route53_record" "alb_alias" {
  zone_id = data.terraform_remote_state.dns_backend.outputs.hostedzone_id
  name    = var.dns_name_to_access_alb
  type    = "A" # Use "AAAA" instead if you need IPv6 dual-stack routing

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}