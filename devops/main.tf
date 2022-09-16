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

<<<<<<< Updated upstream
resource "aws_iam_user" "sample_terraform_user" {
  name = "sample-terraform-user"
}

=======
>>>>>>> Stashed changes
resource "aws_s3_bucket" "tf-state" {
  bucket = "constable-sample-terraform-state"
  acl    = "private"
}

resource "aws_s3_bucket" "financial_data" {
  bucket = "sensitive-financial-data"
  acl    = "private"
}

resource "aws_iam_user" "cfo" {
  name = "chief_financial_officer"
}

resource "aws_iam_user_policy" "cfo" {
  name = "cfo"
  user = aws_iam_user.cfo.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}