{{ config(
    tags=["carmen_sightings", "staging"]
  )
}}

with carmen_sightings as (    
    select *
      from {{ ref('carmen_sightings_europe') }}
)
, column_formatting as (    
    select 'Europe' as region
          ,cast(date_witness as date) as date_witness
          ,cast(witness as varchar) as witness
          ,cast(agent as varchar) as agent
          ,cast(date_filed as date) as date_agent
          ,cast(region_hq as varchar) as city_agent
          ,cast(country as varchar) as country
          ,cast(city as varchar) as city
          ,cast(lat_ as float) as latitude
          ,cast(long_ as float) as longitude
          ,cast("armed?" as boolean) as has_weapon
          ,cast("chapeau?" as boolean) as has_hat
          ,cast("coat?" as boolean) as has_jacket
          ,cast(observed_action as varchar) as behavior
      from carmen_sightings
)
select *
  from column_formatting