terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_security_group" "sg_ssh_http" {
  name        = "sg_ssh_http"
  description = "Ingress for ssh and http"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = [var.cidr_blocks]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_blocks]
  }
}

resource "aws_security_group" "db_group" {
  name        = "db_group"
  description = "Ingress for database"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_blocks]
  }
}

resource "aws_dynamodb_table" "dynamodb" {
  hash_key       = "customer_id"
  range_key      = "customer_name"
  name           = "customers"
  write_capacity = 10
  read_capacity  = 10

  attribute {
    name = "customer_id"
    type = "N"
  }

  attribute {
    name = "customer_name"
    type = "S"
  }
}

resource "aws_db_instance" "postgres" {
  instance_class         = var.pg_db_instance_class
  engine                 = "postgres"
  engine_version         = "13.6"
  allocated_storage      = 10
  name                   = "test_database"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_group.id]
}

resource "aws_iam_role" "web_iam_role" {
  name               = "web_iam_role"
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

resource "aws_iam_role_policy" "web_iam_role_policy" {
  name   = "web_iam_role_policy"
  role   = aws_iam_role.web_iam_role.id
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["dynamodb:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["rds-db:*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "web_instance_profile" {
  name = "web_instance_profile"
  role = aws_iam_role.web_iam_role.name
  path = "/"
}

resource "aws_instance" "web_server" {
  ami                    = var.instanse_ami
  instance_type          = var.instanse_type
  key_name               = var.instanse_key_name
  vpc_security_group_ids = [aws_security_group.sg_ssh_http.id]
  iam_instance_profile   = aws_iam_instance_profile.web_instance_profile.id

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y awscli",
      "sudo amazon-linux-extras install -y postgresql13",
      "aws s3 cp s3://${var.bucket_name}/dynamodb-script.sh /tmp/dynamodb-script.sh",
      "aws s3 cp s3://${var.bucket_name}/rds-script.sql /tmp/rds-script.sql"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.key_path)
    host        = self.public_ip
    timeout     = "4m"
  }
}