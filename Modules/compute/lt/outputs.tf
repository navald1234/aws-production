#################################################
# LAUNCH TEMPLATE ID
#################################################

output "launch_template_id" {

  value = aws_launch_template.web_template.id
}

#################################################
# LAUNCH TEMPLATE ARN
#################################################

output "launch_template_arn" {

  value = aws_launch_template.web_template.arn
}

#################################################
# LAUNCH TEMPLATE LATEST VERSION
#################################################

output "launch_template_latest_version" {

  value = aws_launch_template.web_template.latest_version
}

#################################################
# LAUNCH TEMPLATE NAME
#################################################

output "launch_template_name" {

  value = aws_launch_template.web_template.name
}