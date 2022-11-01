{{ config(
    tags=["carmen_sightings", "staging"]
  )
}}

with carmen_sightings as (    
    select *
      from {{ ref('carmen_sightings_australia') }}
)
, column_formatting as (    
    select 'Australia' as region
          ,cast(witnessed as date) as date_witness
          ,cast(observer as varchar) as witness
          ,cast(field_chap as varchar) as agent
          ,cast(reported as date) as date_agent
          ,cast(interpol_spot as varchar) as city_agent
          ,cast(nation as varchar) as country
          ,cast(place as varchar) as city
          ,cast(lat as float) as latitude
          ,cast(longitude as float) as longitude
          ,cast(has_weapon as boolean) as has_weapon
          ,cast(has_hat as boolean) as has_hat
          ,cast(has_jacket as boolean) as has_jacket
          ,cast(state_of_mind as varchar) as behavior
      from carmen_sightings
)
select *
  from column_formatting