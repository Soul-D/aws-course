variable "ec2_ami_id" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "nat_ec2_ami_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "first_public_subnet_id" {
  type = string
}

variable "second_public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "rds_link" {
  type = string
}

variable "user_data_file" {
  type        = string
  default = "./ec2/user_data.sh"
}