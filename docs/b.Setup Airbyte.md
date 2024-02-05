# Installing and setting up airbyte 

## 0. Prerequisite:
#### - Ensure EC2 instance for airbyte is created following instructions "Creating AWS EC2 Instances.md", and ensure a minimum 20 GB storage
#### - Ensure Snowflake account created

## 1. Start and Connect to EC2 instance for airbyte 
#### 1.1. Select the desired instance
#### 1.2 Click on Action > Start 
#### 1.3. Click on Connect and navigate to the SSH client tab
	- Using Gitbash (Windows) or Terminal (Mac), run the following command:
		ssh -i ~/.ssh/<pem_file_name> ubuntu@<your_instance_public_dns>

## 2. Update Environment:
#### 2.1. Update packages:
		sudo apt update
		sudo apt upgrade -y
		# run this and wait a few moments for the system to reboot before logging back in.
		sudo reboot
#### 2.2. Install docker:
		sudo apt install -y docker.io
#### 2.3. Add the "ubuntu" user to the "docker" group using the following command:
		sudo usermod -aG docker ubuntu
#### 2.4. Exit the current SSH session by running the following command:
		exit
#### 2.5. SSH into your EC2 instance again to apply the group changes
		ssh -i <path to your pem file> ubuntu@<public IP of the EC2 instance>
#### 2.6. Install Docker Compose:
		DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
		mkdir -p $DOCKER_CONFIG/cli-plugins
		curl -SL https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
		chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
		docker compose version

## 3. Install Airbyte:
#### 3.1. copy the script from github repository to the VM: run-ab-platform.sh
#### 3.2. grant execute permission:
		chmod +x run-ab-platform.sh
#### 3.3. run script to start airbyte:
		./run-ab-platform.sh -b

## 4. Sign in Airbyte:
#### 4.1. Use URL:<ip of ec2>:8000
#### 4.2. the default credentials are as follows: 
		- Username: airbyte
		- Password: password
## 5. Setting up the Postgres DB as Source:
#### 5.1. On the left side, click on "Sources" and then search for the specific source you wish to add. 
#### 5.2. For this project, let's use Postgres for the type of source, and provide the details of the AWS RDS connection that holds the Retail Sales Data: 
	- Source Name: DE-RDS
	- HOST:<your Amazon RDS host>
	- Port: 5432
	- Database Name:<your RDS Database Name>
	- Username:<your RDS username>
	- Password:<your RDS password>


## 6. Setting up Snowflake as Destination:
#### 6.1. We set the connection details: 
	- Name:Snowflake
	- Host:<your snowflake host this is an example "de-rds.czm23kqmbd6o.ca-central-1.rds.amazonaws.com">
	- ROLE:ACCOUNTADMIN
	- Warehouse: tpcds
	- Database: TPCDS
	- Default Schema:RAW
	- Username: Your user name
	- Password: your password

## 7. Setting up Connection:
#### 7.1. On the left side, click on "Connections"
#### 7.2. Select the Postgres source you have set up on Step 5
#### 7.3. Select the Snowflake destination you have set up on Step 6
#### 7.4. Configure the replication frequency, which determines how often the pipeline should be triggered 
#### 7.5. Specify the tables to be ingested and their respective synchronization modes
#### 7.6. Click on the "Set Up Connection" button to finalize and establish the connection

## 8. Verify on Snowflake if the tables were created and data transferred



