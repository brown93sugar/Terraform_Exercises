#s3 backend
terraform {
  backend "s3" {
    bucket  = "terraform-first-backend"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
    dynamobd_table = "dynamodb-state-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}