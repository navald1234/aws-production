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
# AMAZON LINUX 2023 AMI
#################################################

data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#################################################
# LAUNCH TEMPLATE
#################################################

resource "aws_launch_template" "web_template" {

  name_prefix   = "${var.environment}-web-template-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    var.ec2_security_group_id
  ]

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.root_volume_size
      volume_type           = var.root_volume_type
      encrypted             = true
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = false
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  #################################################
  # IAM INSTANCE PROFILE
  #################################################

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_ssm_profile.name
  }

  #################################################
  # USER DATA - NGINX + S3
  #################################################

  user_data = base64encode(templatefile(
    "${path.module}/userdata.sh",
    {
      bucket_name = var.portfolio_bucket_name
      aws_region  = var.aws_region
    }
  ))

  #################################################
  # INSTANCE TAGS
  #################################################

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags, {
      Name = "${var.environment}-web-server"
      Type = "application-server"
    })
  }

  #################################################
  # EBS TAGS
  #################################################

  tag_specifications {
    resource_type = "volume"

    tags = merge(local.common_tags, {
      Name = "${var.environment}-web-volume"
    })
  }

  tags = merge(local.common_tags, {
    Name = "${var.environment}-launch-template"
  })

  lifecycle {
    create_before_destroy = true
  }

  update_default_version = true
}

#################################################
# IAM ROLE - EC2 SSM
#################################################

resource "aws_iam_role" "ec2_ssm_role" {

  name = "${var.environment}-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {

  role = aws_iam_role.ec2_ssm_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#################################################
# S3 READ PERMISSION
#################################################

resource "aws_iam_role_policy" "portfolio_s3_access" {

  name = "${var.environment}-portfolio-s3-access"

  role = aws_iam_role.ec2_ssm_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Action = [
        "s3:GetObject",
        "s3:ListBucket"
      ]

      Resource = [
        var.portfolio_bucket_arn,
        "${var.portfolio_bucket_arn}/*"
      ]
    }]
  })
}

#################################################
# IAM INSTANCE PROFILE
#################################################

resource "aws_iam_instance_profile" "ec2_ssm_profile" {

  name = "${var.environment}-ec2-ssm-profile"

  role = aws_iam_role.ec2_ssm_role.name
}