

#################################################
# LOCAL TAGS
#################################################

locals {

  common_tags = {

    Environment = var.environment

    ManagedBy = "Terraform"

    Project = var.project_name
  }
}

#################################################
# TARGET GROUP
#################################################

resource "aws_lb_target_group" "web_tg" {

  name = "${var.environment}-web-tg"

  port = var.target_group_port

  protocol = var.target_group_protocol

  vpc_id = var.vpc_id

  target_type = "instance"

  #################################################
  # HEALTH CHECK
  #################################################

  health_check {

    enabled = true

    path = var.health_check_path

    protocol = "HTTP"

    matcher = "200"

    interval = var.health_check_interval

    timeout = 5

    healthy_threshold = var.healthy_threshold

    unhealthy_threshold = var.unhealthy_threshold
  }

  #################################################
  # DEREGISTRATION DELAY
  #################################################

  deregistration_delay = 30

  #################################################
  # STICKINESS
  #################################################

  stickiness {

    type = "lb_cookie"

    enabled = false
  }

  #################################################
  # LOAD BALANCING ALGORITHM
  #################################################

  load_balancing_algorithm_type = "round_robin"

  #################################################
  # TARGET GROUP TAGS
  #################################################

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-target-group"

      Type = "application-target-group"
    }
  )
}