select *
from {{ ref('core_activity_cleanse') }} a
left join {{ ref ('stg_retailer_metadata') }} b
on a.retailer_name = b.retailer_name
where b.retailer_name is null