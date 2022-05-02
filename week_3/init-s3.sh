#!/bin/bash

rds_script=rds-script.sql
dynamodb_script=dynamodb-script.sh
bucket_name=iam-ozinoviev-db-task
acl=private
region=us-west-2

echo "Create s3 bucket $bucket_name"
aws s3api create-bucket \
    --bucket "$bucket_name" \
    --region "$region" \
    --acl "$acl" \
    --create-bucket-configuration LocationConstraint="$region"

echo "Adding versioning"
aws s3api put-bucket-versioning \
    --bucket "$bucket_name" \
    --versioning-configuration Status=Enabled

echo "Uploading file $rds_script to bucket $bucket_name"
aws s3 cp "$rds_script" s3://"$bucket_name"/

echo "Uploading file $dynamodb_script to bucket $bucket_name"
aws s3 cp "$dynamodb_script" s3://"$bucket_name"/