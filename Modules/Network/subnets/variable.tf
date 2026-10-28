variable "vpc_id" {

  type = string
}

variable "environment" {

  type = string
}

variable "cluster_name" {

  type = string
}

variable "availability_zones" {

  type = list(string)
}

variable "public_subnets" {

  type = list(string)
}

variable "private_subnets" {

  type = list(string)
}

variable "common_tags" {

  type = map(string)
}