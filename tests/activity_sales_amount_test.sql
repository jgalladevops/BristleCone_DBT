select * 
from {{ ref('dim_activity_cleanse') }}
where sales_amount < 0