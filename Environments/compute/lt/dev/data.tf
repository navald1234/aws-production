data "terraform_remote_state" "vpc_backend" {
  
  backend = "s3"

  config = {
    bucket         = "terraform-backend-tfstate-day-03"
    key            = "production/vpc/dev/terraform.tfstate"
    region         = "ap-south-1"
  }
}

