{{
    config(
        materialized='incremental',
        unique_key=['item_sk','warehouse_sk','yr_wk_num'],
        incremental_strategy='merge',
        schema='bi_nltx'
    )
}}


{% if is_incremental() %}
    {% set MAX_SOLD_YR_WK_query %}
        select ifnull(max(yr_wk_num),0) from {{this}} as MAX_SOLD_YR_WK
    {% endset %}

    {% if execute %}
        {% set MAX_SOLD_YR_WK= run_query(MAX_SOLD_YR_WK_query).columns[0][0] %}
    {% endif %}

{% endif %}


{% set get_date_sk_query %}
    select min(d_date_sk) from {{ source('airbyte_raw','date_dim') }}
            {% if is_incremental() %}
                where yr_wk_num = '{{MAX_SOLD_YR_WK}}'
            {% endif %}
{% endset %}

{% if execute %}
        {% set LATEST_DATE_SK = run_query(get_date_sk_query).columns[0][0] %}
{% endif %}



with all_sales as (
        select 
        CS_WAREHOUSE_SK as warehouse_sk, 
        CS_ITEM_SK as item_sk, 
        CS_SOLD_DATE_SK as sold_date_sk, 
        (CS_QUANTITY) as quantity, 
        (CS_SALES_PRICE*cs_quantity) as sales_amt, 
        (CS_NET_PROFIT) as net_profit 
        from {{source('airbyte_raw','catalog_sales')}} 
        WHERE sold_date_sk >= '{{LATEST_DATE_SK}}'

        union

        select 
        WS_WAREHOUSE_SK as warehouse_sk, 
        WS_ITEM_SK as item_sk, 
        WS_SOLD_DATE_SK as sold_date_sk, 
        (WS_QUANTITY) as quantity, 
        (WS_SALES_PRICE *WS_QUANTITY) as sales_amt, 
        (WS_NET_PROFIT) as net_profit
        from {{source('airbyte_raw','web_sales')}}
        WHERE sold_date_sk >= '{{LATEST_DATE_SK}}'


    ),
        daily_sales as (
            select warehouse_sk, 
            item_sk, 
            sold_date_sk,
            yr_num,
            mnth_num,
            yr_wk_num,
            sum(quantity) as daily_quantity,
            sum(net_profit) as daily_profit,
            sum(sales_amt) as daily_sales_amt
            from all_sales
            left join  {{source('airbyte_raw','date_dim')}} on sold_date_sk = D_DATE_SK
            group by 1,2,3,4,5,6
        )


select warehouse_sk,
    item_sk, 
    yr_num,
    mnth_num,
    yr_wk_num, 
    sum(daily_quantity) as sum_qty_wk,
    sum(daily_sales_amt) as sum_amt_wk,
    sum(daily_profit) as sum_profit_wk,
    sum(daily_quantity)/7 as avg_qty_dy,
    sum(coalesce(inv_quantity_on_hand,0)) as inv_on_hand_qty_wk, 
    sum(coalesce(inv_quantity_on_hand, 0)) / sum(daily_quantity) as wks_sply,
    iff(avg_qty_dy>0 and avg_qty_dy>= inv_on_hand_qty_wk, true, false) as low_stock_flg_wk
    from daily_sales
    join {{source('airbyte_raw','inventory')}} on inv_date_sk=sold_date_sk and inv_item_sk=item_sk and inv_warehourse_sk=warehouse_sk
    group by 1,2,3,4,5