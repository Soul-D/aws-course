#!/bin/bash

bucket_name=iam-ozinoviev-final-bucket
acl=private
region=us-west-2
calc='calc-2021-0.0.1-SNAPSHOT.jar'
persist='persist3-2021-0.0.1-SNAPSHOT.jar'

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

echo "Uploading file $calc to bucket $bucket_name"
aws s3 cp jars/$calc s3://$bucket_name/$calc --acl private

echo "Uploading file $persist to bucket $bucket_name"
aws s3 cp jars/$persist s3://$bucket_name/$persist --acl private