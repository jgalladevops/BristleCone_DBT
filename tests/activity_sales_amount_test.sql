select * 
from {{ ref('core_activity_cleanse') }}
where sales_amount < 0