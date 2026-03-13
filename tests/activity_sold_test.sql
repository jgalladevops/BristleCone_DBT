select *
from {{ ref ('dim_activity_cleanse') }}
where units_sold < 0