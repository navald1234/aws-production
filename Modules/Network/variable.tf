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

  type = string

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

  type = string

  default = "0.0.0.0/0"
}

variable "aws_region" {
  default = "ap-south-1"
}