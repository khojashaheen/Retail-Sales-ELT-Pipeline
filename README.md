# Retail-Sales-ELT-Pipeline
## Description
An end-to-end ELT pipeline using AWS infrastructure and Snowflake Data Warehouse to process a Retail Sales dataset, with analytics dashboarding via Metabase.

## Overview
The primary goal of this project is to answer key business questions about top/bottom selling items, inventory levels over time, as well as customer demographics and shopping trends.

<img width="550" alt="SalesDashboard" src="https://github.com/khojashaheen/aws-snowflake-elt-pipeline/assets/132402838/8b2d85be-92ec-4a53-9530-974a8a4f6155">
<img width="450" alt="CustomerProfile" src="https://github.com/khojashaheen/aws-snowflake-elt-pipeline/assets/132402838/d62af794-1571-41f1-b29a-12ec0d0f3ce0">



## System Architecture Overview
The pipeline leveraged a combination of technologies, including: 
- AWS services (S3, RDS, Lambda) and Airbyte for the data extraction and load
- Snowflake Data Warehouse and dbt for data transformation (following Kinball's dimension modeling)
- Metabase for data visualisation
- EC2 instances for hosting Airbyte, Metabase and dbt
  
![WeCloudDataProjects-Phase1_AnalyticalEngineering](https://github.com/khojashaheen/aws-snowflake-elt-pipeline/assets/132402838/8f248f35-e592-4715-8d95-157fef660efc)

## Pre-requisites
- AWS Account: Sign up for an [AWS Account](https://aws.amazon.com/)
- Snowflake Account: Create an account on [Snowflake](https://www.snowflake.com/en/)

## Installation Steps
### 1. Clone the Repository:
	Use git clone https://github.com/khojashaheen/Retail-Sales-ELT-Pipeline to clone this repository to your local machine.

### 2. Complete Pre-requisites Steps:
Ensure you have created an account for AWS and Snowflake

### 3. Create EC2 Instances:
This project leverages Amazon EC2 service to launch Airbyte, dbt and Metabase. Follow the instructions in the [EC2 Instances Creation Document](docs/a.Create%20AWS%20EC2%20Instances.md)

### 4. Set up Airbyte:
While there isn't a dedicated section on running Amazon RDS, you will need to have a source database for this project. You can refer to the official RDS installation guide for instructions.
Once you have the RDS running, you can connect it to Snowflake using Airbyte, which is a modern open-source platform used for data integration. Refer to the [Airbyte Setup Document](docs/b.Setup%20Airbyte.md)

### 5. Set up Lambda:
Lambda is used to transfer inventory files (.csv) from Amazon S3 bucket to Snowflake. Follow the instructions to create a Lambda function and trigger in the [Lambda Setup Document](docs/c.Setup%20AWS%20Lambda.md)

### 6. Data Verification:
Verify the data from sources is loaded into Snowflake Warehouse

### 7. Set up dbt:
dbt is a powerful open-source data transformation tool. In this project, it is used to create the dimension and fact tables in order to answer to answer the key business requirements (top/bottom selling items, weekly inventory levels, low stocks, monthly customer orders etc...). Follow the instructions in the [Dbt Setup Document](docs/d.Setup%20of%20dbt%20models.md)

### 8. Set up Metabase:
Metabase is a an open-source business intelligence tool that you can connect to many popular databases. In this project, I have it connected to snowflake. Follow the instructions in the [Metabase Setup Document](docs/e.Setup%20of%20Metabase.md)
