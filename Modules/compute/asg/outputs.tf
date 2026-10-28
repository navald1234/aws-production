#################################################
# ASG ID
#################################################

output "asg_id" {

  value = aws_autoscaling_group.web_asg.id
}

#################################################
# ASG NAME
#################################################

output "asg_name" {

  value = aws_autoscaling_group.web_asg.name
}

#################################################
# ASG ARN
#################################################

output "asg_arn" {

  value = aws_autoscaling_group.web_asg.arn
}

#################################################
# SCALING POLICY ARN
#################################################

output "scaling_policy_arn" {

  value = aws_autoscaling_policy.cpu_tracking_policy.arn
}