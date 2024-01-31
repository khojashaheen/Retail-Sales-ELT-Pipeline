import json
import requests
import os
import snowflake.connector as sf

#parameters:
url = 'https://de-materials-tpcds.s3.ca-central-1.amazonaws.com/inventory.csv'
dest_folder = '/tmp'
file_name='inventory.csv'

#grab inventory filename from path
def download_file(url):
    response = requests.get(url)
    response.raise_for_status()
    return response;
    
#save it lambda/tmp folder
def save_file(response, dest_folder, file_name):
    file_path = os.path.join(dest_folder,file_name)
    with open(file_path, 'wb') as file:
        file.write(response.content)
    return file_path;

#read file content
def read_file(file_path):
    with open(file_path, 'r') as file: 
        file_content = file.read()
        print(file_content)

def lambda_handler(event, context):
    
    url_response = download_file(url)
    
    file_path = save_file(url_response, dest_folder, file_name)
    
    read_file(file_path)
    
    #loading environment variables saved in configuration tab
    user = os.environ['user']
    password = os.environ['password']
    account = os.environ['account']
    warehouse = 'COMPUTE_WH'
    database= 'TPCDS'
    schema= 'RAW'
    role = 'accountadmin'
    stage_name = 'inventory_stage'
    table = 'INVENTORY'

    
    # connect to snowlfake account:
    conn = sf.connect(user = user, password = password, account = account, 
        warehouse = warehouse ,database= database, schema=schema, role =role)
    cursor = conn.cursor()
    
    #create file_format, stage and upload the file
    snowflake_scripts = [
        f"USE SCHEMA {schema};",
        f"CREATE OR REPLACE FILE FORMAT COMMA_CSV TYPE='CSV' FIELD_DELIMITER=',';",
        f"CREATE OR REPLACE STAGE {stage_name} FILE_FORMAT=COMMA_CSV ;",
        f"PUT 'file://{file_path}' @{stage_name};",
        f"LIST @{stage_name};",
        f"TRUNCATE table {schema}.{table};",
        f"COPY INTO {schema}.{table} FROM @{stage_name}/{file_name} ON_ERROR = 'CONTINUE' FILE_FORMAT=COMMA_CSV;"
        ]
    
    for snflk_script in snowflake_scripts:
        cursor.execute(snflk_script)

    print("File '" + file_path + "' uploaded successfully to Snowflake")
    
    return {
        'statusCode': 200,
        'body': json.dumps('File "' + file_path + '"uploaded successfully to Snowflake')
    }
