
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
        C_FIRST_SHIPTO_DATE_SK,
        CA_STREET_NAME,
        CA_SUITE_NUMBER,
        CA_STATE,
        CA_LOCATION_TYPE,
        CA_COUNTRY,
        CA_ADDRESS_ID,
        CA_COUNTY,
        CA_STREET_NUMBER,
        CA_ZIP,
        CA_CITY,
        CA_GMT_OFFSET,
        CD_DEP_EMPLOYED_COUNT,
        CD_DEP_COUNT,
        CD_CREDIT_RATING,
        CD_EDUCATION_STATUS,
        CD_PURCHASE_ESTIMATE,
        CD_MARITAL_STATUS,
        CD_DEP_COLLEGE_COUNT,
        CD_GENDER,
        HD_BUY_POTENTIAL,
        HD_DEP_COUNT,
        HD_VEHICLE_COUNT,
        HD_INCOME_BAND_SK,
        IB_LOWER_BOUND,
        IB_UPPER_BOUND,
        dbt_valid_from as valid_from,
        dbt_valid_to as valid_to 
from {{ref('customer_snapshot')}}
left join {{source( 'airbyte_raw','customer_address')}} on C_CURRENT_ADDR_SK = CA_ADDRESS_SK
left JOIN {{source( 'airbyte_raw', 'customer_demographics')}} ON C_CURRENT_CDEMO_SK = CD_DEMO_SK
left JOIN {{source( 'airbyte_raw', 'household_demographics')}} ON C_CURRENT_HDEMO_SK = HD_DEMO_SK
left JOIN {{source( 'airbyte_raw', 'income_band')}} ON HD_INCOME_BAND_SK = IB_INCOME_BAND_SK
where dbt_valid_to is null