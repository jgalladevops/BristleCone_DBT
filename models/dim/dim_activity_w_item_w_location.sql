{{
    config(materialized = 'table')
    
}}

with cte_1 as 
( 
select *
from 
{{ref('dim_activity_cleanse')}}
)
,
cte_2 as (
select * from {{ref('dim_item_cleanse')}}
)
,
cte_3 as (
select * from {{ ref('dim_location_cleanse') }}
)

select 
a.retailer_name,
sum(a.units_in_inventory) as total_inventory,
sum(a.units_sold) as total_units_sold,
a.sales_date,
sum(a.sales_amount) as total_sales_amount,
avg(a.retail_price) as avg_retail_price,
avg(a.adjusted_cost) as avg_adjusted_cost,
avg(a.acquired_cost) as avg_acquired_cost,
l.state_name,
l.location_type,
i.category_name,
i.gender,
i.colour,
i.size,
max(a.inserted_at) as inserted_at

from cte_1 as a
left join cte_2 as i 
on a.product_id = i.product_id

left join cte_3 as l 
on a.location_id = l.location_id 

where a.sales_date is not null and a.sales_amount >=0 and a.units_sold >= 0

group by 
a.retailer_name,
a.sales_date,
l.state_name,
l.location_type,
i.category_name,
i.gender,
i.colour,
i.size 


