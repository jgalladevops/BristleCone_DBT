{% snapshot scd_location_timestamp_invalidate %}

{{
    config(
        target_schema='project_deploy_schema',
        unique_key='location_id',
        strategy='timestamp',
        updated_at='insert_timestamp',
        hard_deletes='invalidate'
    )
}}

select * from (
    select *,
    row_number() over (partition by location_id order by insert_timestamp desc) as rn 
     from   
{{ source('RAW','LOCATION')}}
)
where rn = 1

{% endsnapshot %}