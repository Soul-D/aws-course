variable "ec2_ami_id" {
  default = "ami-00ee4df451840fa9d"
}

variable "nat_ami_id" {
  default = "ami-0032ea5ae08aa27a2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}