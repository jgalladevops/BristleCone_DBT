{{
    config(materialized = 'table')
    
}}

with cte_1 as 
( 
select *
from 
{{ref('core_activity_cleanse')}}
)
,
cte_2 as (
select * from {{ref('core_item_cleanse')}}
)
,
cte_3 as (
select * from {{ ref('core_location_cleanse') }}
)

select 
a.sales_date,
a.retailer_name,
nvl(l.location_id, 'UNKNOWN') as location_id,
nvl(l.state_name, 'UNKNOWN') as state_name,
nvl(l.location_type, 'UNKNOWN') as location_type,
a.product_id,
i.category_name,
i.gender,
i.colour,
i.size,
a.units_sold,
a.units_in_inventory,
a.sales_amount,
a.retail_price,
a.adjusted_cost,
case
when (a.sales_amount - (a.units_sold * a.adjusted_cost )) > 0 then 'PROFIT'
when (a.sales_amount - (a.units_sold * a.adjusted_cost )) < 0 then 'LOSS'
else 'BREAK_EVEN' end as profit_loss_status,

CASE 
WHEN a.units_sold > 0 
then round(a.sales_amount / a.units_sold, 2) 
else 0 end as avg_unit_price,

round(a.units_in_inventory * a.retail_price, 2) as inventory_value,
case
when a.units_sold > 0 and a.sales_amount = 0
then 'FREE_OR_PROMOTIONAL'
when a.units_sold > 0 and a.sales_amount > 0
then 'NORMAL_SALE'
else 'NOT_SOLD' end as sales_type,

a.inserted_at

from cte_1 as a
left join cte_2 as i 
on a.product_id = i.product_id

left join cte_3 as l 
on a.location_id = l.location_id 

 


