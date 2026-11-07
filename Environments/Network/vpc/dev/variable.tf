#################################################
# AWS
#################################################

variable "aws_region" {

  type = string

  default = "ap-south-1"
}

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

#################################################
# NETWORKING
#################################################

variable "vpc_cidr" {

  type = string
}

variable "availability_zones" {

  type = list(string)
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

variable "cluster_name" {

  type = string
}

variable "managed_by" {

  type = string

  default = "Terraform"
}

variable "admin_access_cidr" {

  type = string

  default = "0.0.0.0/0"
}