output "instance_id" {
  description = "id of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}