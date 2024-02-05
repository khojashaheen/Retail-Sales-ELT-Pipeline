# Creating EC2 Instances for dbt, airbyte and metabase

## 0. Create AWS account first by following this link
## 1. Create a Security Group
### 1.1 In the EC2 console, click Network & Security -> Security Group
### 1.2 Enter a group name and description.
### 1.3 In Inbound Rules section, click on "Add Rule" to add the following SSH rule(s): 
		- For dbt instance: 
			- Port Range=22, Source=Your IP address

		- For Metabase instance: 
			- Port Range=22, Source=Your IP address
			- Port Range=3000 and Source=Your IP address

		- For Airbyte instance: 
			- Port Range=22, Source=Your IP address
			- Port Range=8000 and Source=Your IP address

### 1.4 Leave the Outbound Rule as is

## 2. Create a Key Pair
### 2.1 In the EC2 console, click Network & Security -> Key Pairs
### 2.2 Enter the keypair name, choose RSA as Key pair type and choose pem as the File format
### 2.3 Then, click Create Key Pair button, which downloads the pem file in your local drive
### 2.4 Put this keypair in a .ssh folder, and change the permission to 400


## 3.Launch an EC2 instance
### 3.1 Before launching the instance, ensure the region is the same as the keypair generated
### 3.2 Launch Instance:
	- Instance Name: Name your instance in a meaninful way to help you identify the instance (ex: ec2_airbyte or ec2_metabase or ec2_dbt)
	- AMI: Ubuntu Server 20.04 LTS
	- Instance Type: 
		- for airbyte, select t2.large size
		- for dbt, select t2.medium size
		- for metabase, select t2.small size
	- Instance Details: choose the default settings
	- Security Group: choose the security group created in step 1.1
	- Key Pair: select the existing key pair created in step 1.2
	- Click on Launch Instance
### 3.3.Click on View Instances
### 3.4 Repeat the process until we have 3 instances for Airbyte, metabase and dbt

## 4.To Start and Connect to an instance
### 4.1. Select the desired instance
### 4.2 Click on Action > Start 
### 4.3. Click on Connect and navigate to the SSH client tab
	- Using Gitbash (Windows) or Terminal (Mac), run the following command:
		ssh -i ~/.ssh/<pem_file_name> ubuntu@<your_instance_public_dns>

## 5.Stop the instance(s) when not used
