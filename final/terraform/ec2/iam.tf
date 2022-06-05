resource "aws_iam_instance_profile" "ec2_instance_profile" {
  role = aws_iam_role.ec2_iam_role.name
}

resource "aws_iam_role" "ec2_iam_role" {
  path = "/"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect : "Allow",
        Principal : {
          Service : "ec2.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_iam_role_policy" {
  role = aws_iam_role.ec2_iam_role.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["sqs:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["sns:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["dynamodb:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}