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
2. cd to the folder with `init-s3.sh` script
3. run script(will be created s3 bucket with name iam-ozinoviev-bucket)
```shell
./init-s3.sh
```
4. check that uploaded file is not publicly available. for example:
```shell
curl --location --request GET 'https://iam-ozinoviev-bucket.s3.us-west-2.amazonaws.com/data.txt'
```
#### 2. Terraform
1. Open regular console
2. cd to the folder with `main.tf` script
3. run script
```shell
terraform apply
```
4. check the file was download successfully:
```shell
ssh -i PATH_TO_YOUR_KEY ec2-user@PUBLIC_DNS_ADDRESS_OF_EC2_INSTANCE
```
then in the container console:
```shell
nano data.txt
```
the content should be `This is the test data`
5. for cleanup resources run:
```shell
terraform destroy
```

### Week 3
#### Databases: RDS, Dynamo DB
1. Open regular console
2. Change dir to `week_3`
3. Run script
```shell
./init-s3.sh
```
4. Change dir to `terraform`
5. Run
```shell
terraform init
terraform apply
```
6. Run the following command:
```shell
ssh -i PATH_TO_YOUR_KEY ec2-user@INSTANCE_PUBLIC_IP_FROM_OUTPUT
```
7. Inside container:
```shell
cd /tmp
chmod +x dynamodb-script.sh
./dynamodb-script.sh

#postgres_connection_host, postgres_connection_port << from output
#db_username, db_password << from your secrets
psql -h postgres_connection_host -p postgres_connection_port -d test_database -U username -f rds-script.sql
exit
```
8. Cleanup:
```shell
terraform destroy
```

### Week 4
#### VPC
1. Open regular console
2. Change dir to `week_4/terraform`
3. Run
```shell
terraform init
terraform apply
```
4. check that load balancer routes requests to different ec2 instances(should be different output):
```shell
curl --location --request GET '<LOAD_BALANCER_DNS_ADDRESS_FROM_OUTPUT>'
```
5. Cleanup:
```shell
terraform destroy
```

### Week 5
#### SQS and SNS
1. Open regular console
2. Change dir to `week_5/terraform`
3. Run
```shell
terraform init
terraform apply
```
4. Go to AWS console UI and setup subscription for SNS.
5. Check that all is work as expected:
```shell
#SNS
aws sns publish --topic <sns_topic_arn_from_output> --message 'Simple notification message' --region us-west-2

#SQS
aws sqs send-message --queue-url <sqs_queue_url_from_output> --message-body 'Simple queue message' --region us-west-2
aws sqs receive-message --queue-url <sqs_queue_url_from_output> --region us-west-2
```
6. Cleanup:
```shell
terraform destroy
```

### Week 6
#### Final
1. Open regular console
2. Change dir to `final/terraform`
3. Run
```shell
terraform init
terraform apply
```
4. Go to AWS console UI and setup subscription for SNS.
5. Check that all is work as expected:
   * Change dir to `final/jars`
   * Run local application:
   ```shell
    java -cp calc-client-1.0-SNAPSHOT-jar-with-dependencies.jar CalcClient <load-balancer-link>
    ```
   * Go to AWS console UI and terminate one of public instances. 
   After some time ASG will recreate EC2 instance and it should automatically load balanced by ELB
   * Go to AWS console UI and pick up public DNS address of public instance.
   * Connect to public instance via SSH
   ```shell
   ssh -i PATH_TO_YOUR_KEY ec2-user@INSTANCE_PUBLIC_DNS_ADDRESS
    ```
   * Check the content of `edu-lohika-training-aws-dynamodb` table in `dynamo db`:
    ```shell
    aws dynamodb scan --table-name edu-lohika-training-aws-dynamodb --region us-west-2
    ```
   * Go to AWS console UI and pick up private IP address of private instance.
   * Connect from public instance to private instance via SSH
   ```shell
   ssh ec2-user@INSTANCE_PRIVATE_IP_ADDRESS
    ```
   * Check the content of `LOGS` table in `postgress`:
   ```shell
    cd /
    psql -h <rds_link> -p 5432 -d EduLohikaTrainingAwsRds -U rootuser -a -f select_logs.sql
    ```
6. Cleanup:
```shell
terraform destroy
```