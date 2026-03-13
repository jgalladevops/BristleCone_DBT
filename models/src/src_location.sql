{{ 
    config(
        materialized = 'table'
    )
}}

select 
sps_retailer_name_key as retailer_name,
sps_customer_location_key as location_id,
state as state_name,
sps_location_type as location_type,
insert_timestamp as inserted_at

from {{ source('RAW','LOCATION' )}}