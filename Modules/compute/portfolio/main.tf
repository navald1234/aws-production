
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
# PORTFOLIO S3 BUCKET
#################################################

resource "aws_s3_bucket" "portfolio" {

  bucket = var.portfolio_bucket_name

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-portfolio"
      Type = "static-website-storage"
    }
  )
}

#################################################
# BLOCK PUBLIC ACCESS
#################################################

resource "aws_s3_bucket_public_access_block" "portfolio" {

  bucket = aws_s3_bucket.portfolio.id

  block_public_acls       = true

  block_public_policy     = true

  ignore_public_acls      = true

  restrict_public_buckets = true
}

#################################################
# ENABLE VERSIONING
#################################################

resource "aws_s3_bucket_versioning" "portfolio" {

  bucket = aws_s3_bucket.portfolio.id

  versioning_configuration {

    status = "Enabled"
  }
}

#################################################
# SERVER SIDE ENCRYPTION
#################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "portfolio" {

  bucket = aws_s3_bucket.portfolio.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"
    }
  }
}
