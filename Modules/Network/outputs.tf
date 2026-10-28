output "vpc_id" {

  value = module.vpc.vpc_id
}

output "public_subnet_ids" {

  value = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {

  value = module.subnets.private_subnet_ids
}

output "internet_gateway_id" {

  value = module.igw.igw_id
}

output "nat_gateway_ids" {

  value = module.nat.nat_gateway_ids
}

output "public_route_table_id" {

  value = module.route_tables.public_route_table_id
}

output "private_route_table_ids" {

  value = module.route_tables.private_route_table_ids
}

#################################################
# ALB SG
#################################################

output "alb_security_group_id" {

  value = module.security_groups.alb_security_group_id
}

#################################################
# EC2 SG
#################################################

output "ec2_security_group_id" {

  value = module.security_groups.ec2_security_group_id
}