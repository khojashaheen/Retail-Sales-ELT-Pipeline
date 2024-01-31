# aws-snowflake-elt-pipeline
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
- AWS Account: Sign up for an AWS Account
- Snowflake: Create an account on Snowflake
- Metabase: Create an account on Metabase

## Installation
