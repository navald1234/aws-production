variable "environment" {

  type = string
}

variable "project_name" {

  type = string
}

variable "domain_name" {

  type = string
}

variable "root_domain" {

  type = string
}

variable "managed_by" {

  type = string

  default = "Terraform"
}

variable "aws_region" {

  type = string

  default = "ap-south-1"
}