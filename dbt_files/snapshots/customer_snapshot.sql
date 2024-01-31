{% snapshot customer_snapshot %}

{{
    config(
        target_schema = 'staging',
        strategy = 'check',
        unique_key = 'c_customer_sk',
        check_cols =  ['c_current_cdemo_sk','c_current_hdemo_sk','c_current_addr_sk','c_email_address']
    )
}}

select C_SALUTATION,
        C_PREFERRED_CUST_FLAG,
        C_FIRST_SALES_DATE_SK,
        C_CUSTOMER_SK,
        C_LOGIN,
        C_CURRENT_CDEMO_SK,
        C_FIRST_NAME,
        C_CURRENT_HDEMO_SK,
        C_CURRENT_ADDR_SK,
        C_LAST_NAME,
        C_CUSTOMER_ID,
        C_LAST_REVIEW_DATE_SK,
        C_BIRTH_MONTH,
        C_BIRTH_COUNTRY,
        C_BIRTH_YEAR,
        C_BIRTH_DAY,
        C_EMAIL_ADDRESS,
        C_FIRST_SHIPTO_DATE_SK
from {{source('airbyte_raw','customer')}}


{% endsnapshot %}