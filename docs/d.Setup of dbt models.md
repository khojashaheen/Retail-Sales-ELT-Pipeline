#Installing and setup of dbt 

## 0. Ensure EC2 instance for dbt is created following instructions: Creating AWS EC2 Instances.md
## 1. Start and Connect to EC2 instance for dbt 
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

###2.2. Install pip:
		sudo apt install python3-pip

## 3. Install DBT:
###3.1. We will install DBT:
		#Install dbt-core and dbt-snowflake
		pip install dbt-core
		pip install dbt-snowflake

###3.2. Add scripts to the PATH:
		# Add this line to the end of your .bashrc and save
		export PATH="$HOME/.local/bin:$PATH"
		# After saving run the following to instantiate the changes
		source .bashrc

###3.3. Validate DBT is installed:
		dbt --version

## 4. dbt Project Setup
###4.1. Initialize the dbt project:
		dbt init <folder_name>
###4.2. Choose Snowflake as your profile
###4.3. Enter your username/password
###4.4. Verify the profiles.yml file created under .dbt
###4.5. Configure the profiles.yml and add the Snowflake credentials
###4.6. dbt debug to verify connectivity to Snowflake DB


## 5. Refer to folder on github repository  "/dbt_files/*" to review the models built for Retail Sales 
