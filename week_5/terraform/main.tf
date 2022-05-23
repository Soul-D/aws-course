terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "public_ec2" {
  ami                    = var.ec2_ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.public_security_group.id]
  key_name               = var.instance_key_name

  iam_instance_profile = aws_iam_instance_profile.iam_instance_profile.name
}

resource "aws_sns_topic" "sns" {
  name = "sns"
}

resource "aws_sqs_queue" "sqs" {
  name = "sqs"
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "iam_instance_profile"
  role = aws_iam_role.iam_role.name
}

resource "aws_iam_role_policy" "iam_role_policy" {
  name = "iam_role_policy"
  role = aws_iam_role.iam_role.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = "sqs:*"
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "sns:*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "iam_role" {
  name = "iam_role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
