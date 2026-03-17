{{ config(
    materialized = 'table'
    )
}}

with cte_2 as 
(
select
* from
{{ ref('stg_location') }}  
)
select 
location_id,
retailer_name,
state_name,
location_type,
inserted_at

from cte_2
where location_id is not null