
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
# ALB SECURITY GROUP
#################################################

resource "aws_security_group" "alb_sg" {

  name = "${var.environment}-alb-sg"

  description = "Security group for Application Load Balancer"

  vpc_id = var.vpc_id

  #################################################
  # HTTP
  #################################################

  ingress {

    description = "Allow HTTP traffic from internet"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #################################################
  # HTTPS
  #################################################

  ingress {

    description = "Allow HTTPS traffic from internet"

    from_port = 443

    to_port = 443

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #################################################
  # OUTBOUND
  #################################################

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-alb-sg"

      Type = "alb-security-group"
    }
  )
}

#################################################
# EC2 SECURITY GROUP
#################################################

resource "aws_security_group" "ec2_sg" {

  name = "${var.environment}-ec2-sg"

  description = "Security group for private EC2 instances"

  vpc_id = var.vpc_id

  #################################################
  # HTTP FROM ALB ONLY
  #################################################

  ingress {

    description = "Allow HTTP traffic only from ALB"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  #################################################
  # SSH ACCESS
  #################################################

  ingress {

    description = "Allow SSH access"

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = var.allowed_ssh_cidr
  }

  #################################################
  # OUTBOUND
  #################################################

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-ec2-sg"

      Type = "ec2-security-group"
    }
  )
}