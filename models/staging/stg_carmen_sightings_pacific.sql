{{ config(
    tags=["carmen_sightings", "staging"]
  )
}}

with carmen_sightings as (    
    select *
      from {{ ref('carmen_sightings_pacific') }}
)
, column_formatting as (    
    select 'Pacific' as region
          ,cast(sight_on as date) as date_witness
          ,cast(sighter as varchar) as witness
          ,cast(filer as varchar) as agent
          ,cast(file_on as date) as date_agent
          ,cast(report_office as varchar) as city_agent
          ,cast(nation as varchar) as country
          ,cast(town as varchar) as city
          ,cast(lat as float) as latitude
          ,cast("long" as float) as longitude
          ,cast(has_weapon as boolean) as has_weapon
          ,cast(has_hat as boolean) as has_hat
          ,cast(has_jacket as boolean) as has_jacket
          ,cast(behavior as varchar) as behavior
      from carmen_sightings
)
select *
  from column_formatting