
#################################################
# ENVIRONMENT
#################################################

variable "environment" {
  type = string
}

#################################################
# PROJECT
#################################################

variable "project_name" {
  type = string
}

variable "managed_by" {
  type    = string
  default = "Terraform"
}

#################################################
# EKS
#################################################

variable "cluster_name" {
  type = string
}

#################################################
# VPC
#################################################

variable "vpc_cidr" {
  type = string
}

#################################################
# SUBNETS
#################################################

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

#################################################
# AZS
#################################################

variable "availability_zones" {
  type = list(string)
}

#################################################
# SECURITY
#################################################

variable "admin_access_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

#################################################
# ROUTE 53 AND SSL
#################################################

variable "hosted_zone_id" {
  type    = string
  default = null
}

variable "subject_alternative_names" {
  type    = list(string)
  default = []
}

variable "domain_name" {
  type    = string
  default = null
}

#################################################
# COMMON TAGS
#################################################

variable "common_tags" {
  type    = map(string)
  default = {}
}
