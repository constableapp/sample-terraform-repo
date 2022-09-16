resource "aws_iam_user" "special_project_sam" {
  name = "special_project_sam"
}

resource "aws_iam_user_policy" "special_project_sam" {
  name = "special_project_sam"
  user = aws_iam_user.special_project_sam.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:List*",
        "s3:Read*",
        "ec2:*",
        "rds:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

