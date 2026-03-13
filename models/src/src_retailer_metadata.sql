{{ 
    config(
        materialized = 'table'
    )
}}

select 
sps_retailer_name_key as retailer_name,
activitygrain

from {{ source('RAW','RETAIL')}}