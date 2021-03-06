resource "aws_instance" "public_ec2" {
  ami                         = var.ec2_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.public_security_group.id]
  key_name                    = var.instance_key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo su
    yum update -y
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    cd /var/www/html
    echo "<html><h1>Public subnet response</h1></html>" > index.html
  EOF

  tags = {
    Name = "public_ec2"
  }
}

resource "aws_instance" "private_ec2" {
  ami                         = var.ec2_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private_subnet.id
  vpc_security_group_ids      = [aws_security_group.private_security_group.id]
  key_name                    = var.instance_key_name
  associate_public_ip_address = false

  user_data = <<-EOF
    #!/bin/bash
    sudo su
    yum update -y
    yum install httpd -y
    service httpd start
    chkconfig httpd on
    cd /var/www/html
    echo "<html><h1>Private subnet response</h1></html>" > index.html
  EOF

  tags = {
    Name = "private_ec2"
  }
}

resource "aws_instance" "nat_ec2" {
  ami                    = var.nat_ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.public_security_group.id]
  source_dest_check      = false
  key_name               = var.instance_key_name

  tags = {
    Name = "nat_ec2"
  }
}