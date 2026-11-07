resource "aws_iam_role" "portfolio_ec2_role" {

  name = "${var.project_name}-${var.environment}-portfolio-role"

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

resource "aws_iam_role_policy" "portfolio_s3_policy" {

  name = "portfolio-s3-read"
  role = aws_iam_role.portfolio_ec2_role.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [{

      Effect = "Allow"

      Action = [
        "s3:GetObject",
        "s3:ListBucket"
      ]

      Resource = [
        aws_s3_bucket.portfolio.arn,
        "${aws_s3_bucket.portfolio.arn}/*"
      ]

    }]
  })
}

resource "aws_iam_instance_profile" "portfolio_profile" {

  name = "${var.project_name}-${var.environment}-portfolio-profile"

  role = aws_iam_role.portfolio_ec2_role.name
}