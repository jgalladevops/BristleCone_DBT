{{ config(
    materialized = 'table'
    )
}}



with cte as
 
(
select
* from
{{ ref('src_activity') }}
  
)
select 
retailer_name,
location_id,
product_id,
to_date(sales_date::string,'yyyymmdd') as sales_date,
case
    when units_in_inventory < 0 then 0
    else units_in_inventory
end as units_in_inventory,

case
    when units_sold < 0 then 0
    else units_sold
end as units_sold,

case 
    when sales_amount < 0 then 0
    else sales_amount
end as sales_amount,
adjusted_cost,
acquired_cost,
retail_price,
inserted_at

from cte