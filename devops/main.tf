terraform {
  backend "s3" {
    bucket         = "constable-sample-terraform-state"
    region         = "us-east-1"
    key            = "terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "sample_terraform_user" {
  name = "sample-terraform-user"
  tags = {
    "key" = "value"
  }
}

resource "aws_s3_bucket" "tf-state" {
  bucket = "constable-sample-terraform-state"
  acl    = "private"
}
