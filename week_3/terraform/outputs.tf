output "postgres_connection_endpoint" {
  description = "Endpoint for postgres database connection"
  value       = aws_db_instance.postgres.endpoint
}

output "postgres_connection_host" {
  description = "Address for postgres database connection"
  value       = aws_db_instance.postgres.address
}

output "postgres_connection_port" {
  description = "Port for postgres database connection"
  value       = aws_db_instance.postgres.port
}

output "dynamodb_table_id" {
  description = "dynamodb table id"
  value       = aws_dynamodb_table.dynamodb.id
}

output "dynamodb_table_arn" {
  description = "AWS resource name of dynamodb table"
  value       = aws_dynamodb_table.dynamodb.arn
}

output "instance_id" {
  description = "EC2 instance id"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "EC2 instance public ip"
  value       = aws_instance.web_server.public_ip
}