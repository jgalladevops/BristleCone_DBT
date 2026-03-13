{% snapshot scd_location_timestamp_ignore %}

{{
    config(
        target_schema='project_deploy_schema',
        unique_key='location_id',
        strategy='timestamp',
        updated_at='insert_timestamp',
        hard_deletes='invalidate'
    )
}}

select * from 
{{ source('RAW','LOCATION')}}
 

{% endsnapshot %}