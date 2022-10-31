{{ config(
    tags=["carmen_sightings", "staging"]
  )
}}

with carmen_sightings as (    
    select *
      from {{ ref('carmen_sightings_asia') }}
)
, column_formatting as (    
    select 'Asia' as region
          ,cast(sighting as date) as date_witness
          ,cast(citizen as varchar) as witness
          ,cast(officer as varchar) as agent
          ,cast("报道" as date) as date_agent
          ,cast(city_interpol as varchar) as city_agent
          ,cast(nation as varchar) as country
          ,cast(city as varchar) as city
          ,cast("纬度" as float) as latitude
          ,cast("经度" as float) as longitude
          ,cast(has_weapon as boolean) as has_weapon
          ,cast(has_hat as boolean) as has_hat
          ,cast(has_jacket as boolean) as has_jacket
          ,cast(behavior as varchar) as behavior
      from carmen_sightings
)
select *
  from column_formatting