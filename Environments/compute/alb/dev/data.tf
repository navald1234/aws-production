data "terraform_remote_state" "vpc_backend" {

  backend = "s3"

  config = {
    bucket = "terraform-backend-tfstate-day-03"
    key    = "production/vpc/dev/terraform.tfstate"
    region = "ap-south-1"
  }
}


data "terraform_remote_state" "acm_backend" {
  backend = "s3"

  config = {
    bucket = "terraform-backend-tfstate-day-03"
    key    = "compute/alb/dev/prod-proj/terraform.tfstate"
    region = "ap-south-1"


  }
}

data "terraform_remote_state" "tg_backend" {
  backend = "s3"

  config = {

    bucket = "terraform-backend-tfstate-day-03"
    key    = "production/tg/test/terraform.tfstate"
    region = "ap-south-1"

  }
}

data "terraform_remote_state" "dns_backend" {

  backend = "s3"

  config = {
    bucket = "terraform-backend-tfstate-day-03"
    key    = "production/dns/test/terraform.tfstate"
    region = "ap-south-1"
  }
}


# data "terraform_remote_state" "alb_backend" {
#   backend = "s3"

#   config = {

#    bucket = "terraform-backend-bucket-vishal"
#     key    = "Compute/ALB/dev/prod-proj/terraform.tfstate"
#     region = "ap-south-1"

#   }
# }