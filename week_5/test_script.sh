#!/bin/bash

#SNS
aws sns publish --topic arn:aws:sns:us-west-2:829046718916:sns --message 'Simple notification message' --region us-west-2

#SQS
aws sqs send-message --queue-url https://sqs.us-west-2.amazonaws.com/829046718916/sqs --message-body 'Simple queue message' --region us-west-2
aws sqs receive-message --queue-url https://sqs.us-west-2.amazonaws.com/829046718916/sqs --region us-west-2