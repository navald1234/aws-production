terraform {
  backend "s3" {
     bucket         = "terraform-backend-tfstate-day-03"
    key            = "production/lt/test/terraform.tfstate"
    region         = "ap-south-1"
 }
}