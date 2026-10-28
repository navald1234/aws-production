#################################################
# LOCAL TAGS
#################################################

locals {

  common_tags = {

    Environment = var.environment

    ManagedBy   = "Terraform"

    Project     = var.project_name
  }
}

#################################################
# APPLICATION LOAD BALANCER
#################################################

resource "aws_lb" "alb" {

  name = "${var.environment}-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    var.alb_security_group_id
  ]

  subnets = var.public_subnet_ids

  #################################################
  # HARDENING
  #################################################

  enable_deletion_protection       = var.enable_deletion_protection

  drop_invalid_header_fields       = true

  idle_timeout                     = var.idle_timeout

  enable_cross_zone_load_balancing = true

  #################################################
  # TAGS
  #################################################

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-alb"

      Type = "application-load-balancer"
    }
  )
}

#################################################
# HTTP LISTENER
#################################################

resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.alb.arn

  port = 80

  protocol = "HTTP"

  #################################################
  # REDIRECT HTTP TO HTTPS
  #################################################

  default_action {

    type = "redirect"

    redirect {

      port = "443"

      protocol = "HTTPS"

      status_code = "HTTP_301"
    }
  }

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-http-listener"
    }
  )
}

#################################################
# HTTPS LISTENER
#################################################

resource "aws_lb_listener" "https" {

  load_balancer_arn = aws_lb.alb.arn

  port = 443

  protocol = "HTTPS"

  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  certificate_arn = var.acm_certificate_arn

  #################################################
  # FORWARD TO TARGET GROUP
  #################################################

  default_action {

    type = "forward"

    target_group_arn = var.target_group_arn
  }

  #################################################
  # TAGS
  #################################################

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-https-listener"
    }
  )
}