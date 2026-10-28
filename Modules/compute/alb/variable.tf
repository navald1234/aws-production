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

variable "vpc_id" {

  type = string
}

variable "public_subnet_ids" {

  type = list(string)
}

#################################################
# SECURITY GROUP
#################################################

variable "alb_security_group_id" {

  type = string
}

#################################################
# TARGET GROUP
#################################################

variable "target_group_arn" {

  type = string
}

#################################################
# LOAD BALANCER SETTINGS
#################################################

variable "enable_deletion_protection" {

  type = bool

  default = false
}

variable "idle_timeout" {

  type = number

  default = 60
}
variable "acm_certificate_arn" {

  type = string
}

variable "aws_region" {
  
}