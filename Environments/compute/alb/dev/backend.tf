terraform {
  backend "s3" {
    bucket = "terraform-backend-tfstate-day-03"
    key    = "production/alb/test/terraform.tfstate"
    region = "ap-south-1"
  }
}