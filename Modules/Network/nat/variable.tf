variable "environment" {

  type = string
}

variable "igw_id" {

  type = string
}

variable "public_subnet_ids" {

  type = list(string)
}

variable "common_tags" {

  type = map(string)
}