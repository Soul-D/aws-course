#!/bin/bash

file_name=data.txt
default_bucket_name=my-bucket-$(date +%s)
bucket_name=${1-$default_bucket_name}
acl=private
region=us-west-2

echo "Create file $file_name"
echo 'This is the test data' > "$file_name"

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

echo "Uploading file $file_name to bucket $bucket_name"
aws s3 cp data.txt s3://"$bucket_name"/

echo "Remove local file $file_name"
rm data.txt