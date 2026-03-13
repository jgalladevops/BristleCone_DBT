{{ 
    config(
        materialized = 'table'
    )
}}

SELECT
sps_retailer_name_key as retailer_name,
sps_customer_location_key as location_id,
sps_customer_item_key as product_id,
period_ending_date as sales_date,
inventory_units as units_in_inventory,
net_sales_units as units_sold,
net_sales_retail as sales_amount,
corporate_unit_adjusted_cost as adjusted_cost,
corporate_unit_acquired_cost as acquired_cost,
corporate_unit_owned_retail_price as retail_price,
insert_timestamp as inserted_at

FROM {{ source('RAW','ACTIVITY' )}}
where sales_date is not null