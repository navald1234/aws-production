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
# SUBNETS
#################################################

variable "private_subnet_ids" {

  type = list(string)
}

#################################################
# LAUNCH TEMPLATE
#################################################

variable "launch_template_id" {

  type = string
}

variable "launch_template_latest_version" {

  type = string
}

#################################################
# TARGET GROUP
#################################################

variable "target_group_arn" {

  type = string
}

#################################################
# ASG CAPACITY
#################################################

variable "min_size" {

  type = number

  default = 2
}

variable "max_size" {

  type = number

  default = 4
}

variable "desired_capacity" {

  type = number

  default = 2
}

#################################################
# SCALING
#################################################

variable "target_cpu_utilization" {

  type = number

  default = 50
}

variable "health_check_grace_period" {

  type = number

  default = 300
}

variable "aws_region" {
  type = string
}