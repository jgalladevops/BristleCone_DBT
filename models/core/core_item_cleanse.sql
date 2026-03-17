{{ config(
    materialized = 'table'
    )
}}



with cte_1 as
 
(
 
select
* from
{{ ref('stg_item') }}
  
)
 
select 
product_id,
category_name,
case 
    when gender is null then 'UNKNOWN'
    else trim(upper(gender))
end as gender,
colour,
size,
inserted_at 
from cte_1
 