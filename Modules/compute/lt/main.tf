
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
# AMAZON LINUX 2023 AMI
#################################################

data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {

    name = "name"

    values = ["al2023-ami-*-x86_64"]
  }

  filter {

    name = "virtualization-type"

    values = ["hvm"]
  }
}

#################################################
# LAUNCH TEMPLATE
#################################################

resource "aws_launch_template" "web_template" {

  name_prefix = "${var.environment}-web-template-"

  image_id = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type

  key_name = var.key_name

  #################################################
  # SECURITY GROUP
  #################################################

  vpc_security_group_ids = [
    var.ec2_security_group_id
  ]

  #################################################
  # EBS VOLUME
  #################################################

  block_device_mappings {

    device_name = "/dev/xvda"

    ebs {

      volume_size = var.root_volume_size

      volume_type = var.root_volume_type

      encrypted = true

      delete_on_termination = true
    }
  }

  #################################################
  # MONITORING
  #################################################

  monitoring {

    enabled = false
  }

  #################################################
  # INSTANCE METADATA OPTIONS
  #################################################

  metadata_options {

    http_endpoint = "enabled"

    http_tokens = "required"

    http_put_response_hop_limit = 2
  }


 # SSM 
 ################################
 iam_instance_profile {
  name = aws_iam_instance_profile.ec2_ssm_profile.name
}
  #################################################
  # USER DATA
  #################################################



user_data = base64encode(<<-EOF
#!/bin/bash
set -euxo pipefail

exec > /var/log/user-data.log 2>&1

dnf install -y httpd amazon-ssm-agent

echo "Hii from Server: $(hostname)" > /var/www/html/index.html

systemctl enable --now httpd
systemctl enable --now amazon-ssm-agent
EOF
)



  #################################################
  # TAG SPECIFICATIONS
  #################################################

  tag_specifications {

    resource_type = "instance"

    tags = merge(

      local.common_tags,

      {

        Name = "${var.environment}-web-server"

        Type = "application-server"
      }
    )
  }

  #################################################
  # EBS TAGS
  #################################################

  tag_specifications {

    resource_type = "volume"

    tags = merge(

      local.common_tags,

      {

        Name = "${var.environment}-web-volume"
      }
    )
  }

  #################################################
  # LAUNCH TEMPLATE TAGS
  #################################################

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-launch-template"
    }
  )

  #################################################
  # LIFECYCLE
  #################################################

  lifecycle {

    create_before_destroy = true
  }

  #################################################
  # VERSION MANAGEMENT
  #################################################

  update_default_version = true
}


resource "aws_iam_role" "ec2_ssm_role" {
  name = "dev-ec2-ssm-role"

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

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "dev-ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}