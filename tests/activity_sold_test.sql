select *
from {{ ref ('core_activity_cleanse') }}
where units_sold < 0