#### The assignments for course "AWS Developer Fundamentals"

### Week 0
#### how to run template
1. Open AWS CLI
2. Run the following command:
```
aws cloudformation create-stack \
--stack-name YOUR_STACK_NAME \
--template-body file:///YOUR_SCRIPT_LOCATION \
--parameters ParameterKey=KeyName,ParameterValue=YOUR_KEY_NAME ParameterKey=InstanceType,ParameterValue=t2.micro ParameterKey=TestInputParam,ParameterValue=YOUR_INPUT \
--region us-west-2
```

### Week 1
#### how to check java
1. Open regular console
2. Run the following command:
```shell
ssh -i PATH_TO_YOUR_KEY ec2-user@PUBLIC_DNS_ADDRESS_OF_EC2_INSTANCE
# here probably you should wait for some minutes until java will be installed
java -version
```

### Week 2
#### 1. S3 bucket
1. Open regular console
2. cd to the folder with init-s3.sh script
3. run script with optional parameter(if not set then will be created s3 bucket with name my-bucket-[current timestamp])
```shell
./init-s3.sh <OPTIONAL_BUCKET_NAME>
```
4. check that uploaded file is not publicly available. for example:
```shell
curl --location --request GET 'https://<BUCKET_NAME>.s3.us-west-2.amazonaws.com/data.txt'
```
