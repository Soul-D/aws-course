#### The assignments for course "AWS Developer Fundamentals"

### How to run:
1. Open AWS CLI
2. Run the following command:
```
aws cloudformation create-stack \
--stack-name YOUR_STACK_NAME \
--template-body file:///YOUR_SCRIPT_LOCATION \
--parameters ParameterKey=KeyName,ParameterValue=YOUR_KEY_NAME ParameterKey=InstanceType,ParameterValue=t2.micro ParameterKey=TestInputParam,ParameterValue=YOUR_INPUT \
--region us-west-2
```