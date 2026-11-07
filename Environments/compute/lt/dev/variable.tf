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
# EC2
#################################################

variable "instance_type" {

  type = string

  default = "t2.micro"
}

variable "key_name" {

  type = string
}

#################################################
# AUTO SCALING
#################################################

variable "min_size" {

  type = number
}

variable "max_size" {

  type = number
}

variable "desired_capacity" {

  type = number
}

variable "domain_name" {

  type = string
}