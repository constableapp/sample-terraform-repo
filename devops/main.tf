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

resource "aws_s3_bucket" "tf-state" {
  bucket = "constable-sample-terraform-state"
  acl    = "private"
}

resource "aws_s3_bucket" "financial_data" {
  bucket = "sensitive-financial-data"
  acl    = "private"
}

resource "aws_iam_role" "long_lived_session_role" {
  name = "long_lived_session_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "*"
        }
      },
    ]
  })

  max_session_duration = 43200
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

