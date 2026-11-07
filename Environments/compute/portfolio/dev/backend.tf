terraform {
  backend "s3" {

    bucket = "terraform-backend-tfstate-day-03"

    key = "compute/portfolio/dev/terraform.tfstate"

    region = "ap-south-1"
  }
}