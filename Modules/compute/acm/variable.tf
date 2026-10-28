#################################################
# ENVIRONMENT
#################################################

variable "environment" {

  type = string
}

#################################################
# ACM
#################################################

variable "domain_name" {

  type = string
}

variable "subject_alternative_names" {

  type = list(string)

  default = []
}

variable "hosted_zone_id" {

  type = string
}

################################################
# TAGS
#################################################

variable "common_tags" {

  type = map(string)

  default = {}
}

variable "aws_region" {
  
}