output "bucket_name" {
  description = "Portfolio S3 bucket name"
  value       = aws_s3_bucket.portfolio.bucket
}

output "bucket_arn" {
  description = "Portfolio S3 bucket ARN"
  value       = aws_s3_bucket.portfolio.arn
}