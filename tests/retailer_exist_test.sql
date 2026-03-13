select *
from {{ ref('dim_activity_cleanse') }} a
left join {{ ref ('src_retailer_metadata') }} b
on a.retailer_name = b.retailer_name
where b.retailer_name is null