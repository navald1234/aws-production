

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
# AUTO SCALING GROUP
#################################################

resource "aws_autoscaling_group" "web_asg" {

  name = "${var.environment}-web-asg"

  #################################################
  # NETWORK
  #################################################

  vpc_zone_identifier = var.private_subnet_ids

  #################################################
  # CAPACITY
  #################################################

  min_size = var.min_size

  max_size = var.max_size

  desired_capacity = var.desired_capacity

  # #################################################
  # HEALTH CHECK
  # ################################################

  health_check_type = "ELB"

  health_check_grace_period = var.health_check_grace_period

  #################################################
  # TARGET GROUP
  #################################################

  target_group_arns = [
    var.target_group_arn
  ]

  #################################################
  # LAUNCH TEMPLATE
  #################################################

  launch_template {

    id = var.launch_template_id

    version = var.launch_template_latest_version
  }

  #################################################
  # INSTANCE WARMUP
  #################################################

  default_instance_warmup = 120

  #################################################
  # METRICS
  #################################################

  enabled_metrics = [

    "GroupDesiredCapacity",

    "GroupInServiceInstances",

    "GroupMinSize",

    "GroupMaxSize",

    "GroupPendingInstances",

    "GroupTerminatingInstances",

    "GroupTotalInstances"
  ]

  #################################################
  # INSTANCE REFRESH
  #################################################

  instance_refresh {

    strategy = "Rolling"

    preferences {

      min_healthy_percentage = 50

      instance_warmup = 120
    }

    triggers = [
      "launch_template"
    ]
  }

  #################################################
  # TAGS
  #################################################

  dynamic "tag" {

    for_each = merge(

      local.common_tags,

      {

        Name = "${var.environment}-web-server"

        Type = "application-server"
      }
    )

    content {

      key = tag.key

      value = tag.value

      propagate_at_launch = true
    }
  }

  #################################################
  # LIFECYCLE
  #################################################

  lifecycle {

    create_before_destroy = true
  }
}

#################################################
# TARGET TRACKING SCALING POLICY
#################################################

resource "aws_autoscaling_policy" "cpu_tracking_policy" {

  name = "${var.environment}-cpu-scaling-policy"

  autoscaling_group_name = aws_autoscaling_group.web_asg.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {

    predefined_metric_specification {

      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_cpu_utilization
  }
}