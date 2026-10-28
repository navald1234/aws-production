#################################################
# ALB
#################################################

output "alb_dns_name" {

  value = module.alb.alb_dns_name
}

output "alb_arn" {

  value = module.alb.alb_arn
}


output "alb_id" {

  value = module.alb.alb_id
}

output "alb_zone_id" {

  value = module.alb.alb_zone_id
}