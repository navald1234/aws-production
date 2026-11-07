data "terraform_remote_state" "vpc_backend" {
  
  backend = "s3"

  config = {
    bucket         = "terraform-backend-tfstate-day-03"
    key            = "production/vpc/dev/terraform.tfstate"
    region         = "ap-south-1"
  }
}





data "terraform_remote_state" "tg_backend" {
  backend = "s3"

  config = {

     bucket         = "terraform-backend-tfstate-day-03"
    key            = "production/tg/test/terraform.tfstate"
    region         = "ap-south-1"
  }

  }

data "terraform_remote_state" "lt_backend" {
  backend = "s3"

  config = {

      bucket         = "terraform-backend-tfstate-day-03"
    key            = "production/lt/test/terraform.tfstate"
    region         = "ap-south-1"

  }
}