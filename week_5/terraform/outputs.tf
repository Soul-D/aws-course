output "ec2_public_ip" {
  value = aws_instance.public_ec2.public_ip
}

output "sns_topic_arn" {
  value = aws_sns_topic.sns.arn
}

output "sqs_queue_url" {
  value = aws_sqs_queue.sqs.id
}