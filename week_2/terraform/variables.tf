variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80]
}

variable "cidr_blocks" {
  description = "cidr block for security group"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instanse_ami" {
  description = "value of the ami for the EC2 instance"
  type        = string
  default     = "ami-00ee4df451840fa9d"
}

variable "instanse_type" {
  description = "type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "bucket_name" {
  description = "s3 bucket name"
  type        = string
  default     = "iam-ozinoviev-bucket"
}

