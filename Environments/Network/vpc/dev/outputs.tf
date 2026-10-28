output "vpc_id" {

  value = module.aws_vpc.vpc_id
}

output "public_subnet_ids" {

  value = module.aws_vpc.public_subnet_ids
}

output "private_subnet_ids" {

  value = module.aws_vpc.private_subnet_ids
}

output "nat_gateway_ids" {

  value = module.aws_vpc.nat_gateway_ids
}

output "alb_security_group_id" {

  value = module.aws_vpc.alb_security_group_id
}

#################################################
# EC2 SG
#################################################

output "ec2_security_group_id" {

  value = module.aws_vpc.ec2_security_group_id
}