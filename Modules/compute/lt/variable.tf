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
# INSTANCE CONFIGURATION
#################################################

variable "instance_type" {

  type = string

  default = "t3.micro"
}

variable "key_name" {

  type = string
}

#################################################
# SECURITY GROUP
#################################################

variable "ec2_security_group_id" {

  type = string
}

#################################################
# ROOT VOLUME
#################################################

variable "root_volume_size" {

  type = number

  default = 30
}

variable "root_volume_type" {

  type = string

  default = "gp2"
}

variable "aws_region" {
  type = string
}
variable "iam_instance_profile_name" {
  type = string
}

variable "user_data" {
  type = string
}
variable "portfolio_bucket_arn" {
  type = string
  
}
variable "portfolio_bucket_name" {
  type = string
  
}