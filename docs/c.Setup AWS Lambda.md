#Installing and setting up Lambda

## 0. Prerequisite:
	- Ensure Amazon account created

## 1. Create a function:
### 1.1 Nagivate to Lambda Dashboard and Create a Function
### 1.2 Select a blueprint "Hello World" function, with Python runtime
### 1.3 Fill out the basic information (function name, new role_name, policy template)

## 2. Refer to file on github repository "lambda_scripts.py" to review the logic of retrieving files from an S3 bucket and writing it to a Snowflake table via stage
### 2.1 Create an environment variables to store Snowflake credentials
### 2.2 Create a trigger on S3 bucket every time the inventory file is uploaded to execute the Lambda script




