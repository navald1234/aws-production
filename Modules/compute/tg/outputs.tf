#################################################
# TARGET GROUP ID
#################################################

output "target_group_id" {

  value = aws_lb_target_group.web_tg.id
}

#################################################
# TARGET GROUP ARN
#################################################

output "target_group_arn" {

  value = aws_lb_target_group.web_tg.arn
}

#################################################
# TARGET GROUP NAME
#################################################

output "target_group_name" {

  value = aws_lb_target_group.web_tg.name
}