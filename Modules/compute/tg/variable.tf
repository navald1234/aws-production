


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
# VPC
#################################################

variable "vpc_id" {

  type = string
}

#################################################
# TARGET GROUP
#################################################

variable "target_group_port" {

  type = number

  default = 80
}

variable "target_group_protocol" {

  type = string

  default = "HTTP"
}

#################################################
# HEALTH CHECK
#################################################

variable "health_check_path" {

  type = string

  default = "/"
}

variable "health_check_interval" {

  type = number

  default = 30
}

variable "healthy_threshold" {

  type = number

  default = 2
}

variable "unhealthy_threshold" {

  type = number

  default = 3
}


variable "aws_region" {
  
}