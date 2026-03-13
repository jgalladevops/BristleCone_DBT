{{ 
    config(
        materialized = 'table'
    )
}}

SELECT 
sps_customer_item_key as product_id,
category_name,
gender,
color_name as colour,
size_name as size, 
insert_timestamp as inserted_at

from {{ source('RAW','ITEM') }}