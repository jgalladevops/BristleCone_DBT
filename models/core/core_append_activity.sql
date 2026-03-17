{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'append'
    )
}}


WITH src_activity
AS
(
  SELECT * FROM {{ ref('stg_activity') }}
)
select 
retailer_name,
location_id,
product_id,
sales_date,
units_in_inventory,
units_sold,
sales_amount,
adjusted_cost,
acquired_cost,
retail_price,
inserted_at
from src_activity

where sales_date is not null 
 
 {% if is_incremental() %}
 and inserted_at > (select max(inserted_at) from {{this}}
 )
{% endif %}