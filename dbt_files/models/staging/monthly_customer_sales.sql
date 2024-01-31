{{
    config(
        materialized='incremental',
        unique_key=['customer_sk','yr_mnth_num'],
        incremental_strategy='merge',
        schema='bi_nltx'
    )
}}


{% if is_incremental() %}
    {% set MAX_SOLD_YR_MNTH_query %}
        select ifnull(max(yr_mnth_num),0) from {{this}} as MAX_SOLD_YR_MNTH
    {% endset %}

    {% if execute %}
        {% set MAX_SOLD_YR_MNTH= run_query(MAX_SOLD_YR_MNTH_query).columns[0][0] %}
    {% endif %}

{% endif %}


{% set get_date_sk_query %}
    select min(d_date_sk) from {{ source('airbyte_raw','date_dim') }}
            {% if is_incremental() %}
                where yr_mnth_num = '{{MAX_SOLD_YR_MNTH}}'
            {% endif %}
{% endset %}

{% if execute %}
        {% set LATEST_DATE_SK = run_query(get_date_sk_query).columns[0][0] %}
{% endif %}


with all_sales as (
        select 
        cs_bill_customer_sk as customer_sk,
        CS_SOLD_DATE_SK as sold_date_sk, 
        (CS_QUANTITY) as quantity, 
        (CS_SALES_PRICE*cs_quantity) as sales_amt, 
        cs_order_number as order_num,
        1 as sales_category
        from {{source('airbyte_raw','catalog_sales')}} 
        WHERE sold_date_sk >= '{{LATEST_DATE_SK}}' and cs_bill_customer_sk is not null

        union

        select 
        ws_bill_customer_sk as customer_sk,
        WS_SOLD_DATE_SK as sold_date_sk, 
        (WS_QUANTITY) as quantity, 
        (WS_SALES_PRICE *WS_QUANTITY) as sales_amt, 
        ws_order_number as order_num,
        2 as sales_category
        from {{source('airbyte_raw','web_sales')}}
        WHERE sold_date_sk >= '{{LATEST_DATE_SK}}' and ws_bill_customer_sk is not null

    )

select
    customer_sk,
    yr_num,
    mnth_num,
    yr_mnth_num,
    sales_category,
    sum(quantity) as monthly_quantity,
    sum(sales_amt) as monthly_sales_amt,
    count(distinct order_num) as monthly_order_frequency
    from all_sales
    left join  {{source('airbyte_raw','date_dim')}} on sold_date_sk = D_DATE_SK
    group by 1,2,3,4,5
