resource "aws_s3_bucket" "portfolio" {

  bucket = "${var.project_name}-${var.environment}-portfolio"

  tags = {
    Name        = "portfolio-website"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "portfolio" {

  bucket = aws_s3_bucket.portfolio.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}