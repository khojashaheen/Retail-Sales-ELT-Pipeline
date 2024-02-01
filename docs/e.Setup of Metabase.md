#Installing and setting up airbyte 


## 0. Prerequisite:
### - Ensure EC2 instance for airbyte is created following instructions "Creating AWS EC2 Instances.md"
### - Ensure Snowflake account created

## 1. Start and Connect to EC2 instance for airbyte 
###1.1. Select the desired instance
###1.2 Click on Action > Start 
###1.3. Click on Connect and navigate to the SSH client tab
	- Using Gitbash (Windows) or Terminal (Mac), run the following command:
		ssh -i ~/.ssh/<pem_file_name> ubuntu@<your_instance_public_dns>

## 2. Update Environment:
###2.1. Update packages:
		sudo apt update
		sudo apt upgrade -y
		# run this and wait a few moments for the system to reboot before logging back in.
		sudo reboot
###2.2. Install docker:
		sudo apt install -y docker.io

##3. Install Metabase on EC2 Instance
###3.1. Pull the Metabase docker image:
		docker pull metabase/metabase:latest

###3.2. Run the docker container, the command will launch Metabase server on port 3000 by default:
		docker run -d -p 3000:3000 --name metabase metabase/metabase
		# if you want to see the logs as metabase installs then run.  control + c to quit.
		docker logs -f metabase

###3.3. Exit the current SSH session by running the following command:
		exit
###3.4. SSH into your EC2 instance again to apply the group changes
		ssh -i <SSH_KEY.pem> -L 3000:<Public IPv4 address>:3000 -N -f ubuntu@<INSTANCE_IP>
###3.5 Visit http://<Public IPv4 address>:3000 on your local browser to verify installation worked correctly

##4. Connect to Snowflake Database
###4.1. To add a connection, click on the gear icon on the top right
###4.2. Navigate to Admin settings > Databases > Add a database
###4.3. Enter Snowflake database connection details, then click on Save to ensure Metabase can connect to your database successfully


##5. Build Your Dashboard
###5.1. Review Data Model Properties:
	- Click on the gear icon in the top right
	- Navigate to Admin Settings > Data Model
	- Locate your database and table
	- Click on the gear icon at the right of a column
	- You can change the data model's properties as needed (ex: Visbility, Field Type, Filtering)
	- Exit admin mode once done

###5.2. Create Collections (organizational structures to group dashboards, questions, ex: folders)
###5.3. Create Questions (aka query builder) from either Raw Data, or a saved question, or even a model
###5.4. Create Dashboards and add saved questions, as well as filters

