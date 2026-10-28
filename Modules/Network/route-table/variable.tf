variable "vpc_id" {

  type = string
}

variable "igw_id" {

  type = string
}

variable "nat_gateway_ids" {

  type = list(string)
}

variable "public_subnet_ids" {

  type = list(string)
}

variable "private_subnet_ids" {

  type = list(string)
}

variable "common_tags" {

  type = map(string)

  default = {}
}

variable "environment" {

  type = string

  default = "dev"
}