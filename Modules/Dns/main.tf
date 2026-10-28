resource "aws_route53_zone" "main" {
  name = var.domain_name
  comment       = "Managed by Terraform"
  force_destroy = false
}