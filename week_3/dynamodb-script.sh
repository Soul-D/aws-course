#!/bin/bash

echo "<----get list of tables---->"
aws dynamodb list-tables --region us-west-2

#aws dynamodb create-table \
#    --table-name customers \
#    --attribute-definitions \
#        AttributeName=customer_id,AttributeType=N \
#        AttributeName=customer_name,AttributeType=S \
#    --key-schema \
#        AttributeName=customer_id,KeyType=HASH \
#        AttributeName=customer_name,KeyType=RANGE \
#    --provisioned-throughput \
#        ReadCapacityUnits=10,WriteCapacityUnits=10us \
#    --table-class STANDARD \
#    --region us-west-2

echo "<----adding the first customer---->"
aws dynamodb put-item \
    --table-name customers  \
    --item \
        '{"customer_id": {"N": "1"}, "customer_name": {"S": "Oleh"}, "added_time": {"S": "'$(date +%s)'"} }' \
    --region us-west-2

echo "<----adding the second customer---->"
aws dynamodb put-item \
    --table-name customers \
    --item \
        '{"customer_id": {"N": "2"}, "customer_name": {"S": "Olha"}, "added_time": {"S": "'$(date +%s)'"} }' \
    --region us-west-2

echo "<----get value with key -> '{'customer_id': '1', 'customer_name': 'Oleh'}}'---->"
aws dynamodb get-item --table-name customers --key '{"customer_id": {"N":"1"}, "customer_name": {"S":"Oleh"}}' --region us-west-2

echo "<----get value with key -> '{'customer_id': '2', 'customer_name': 'Olha'}}'---->"
aws dynamodb get-item --table-name customers --key '{"customer_id": {"N":"2"}, "customer_name": {"S":"Olha"}}' --region us-west-2