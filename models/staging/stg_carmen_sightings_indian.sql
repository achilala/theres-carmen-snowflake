{{ config(
    tags=["carmen_sightings", "staging"]
  )
}}

with carmen_sightings as (    
    select *
      from {{ ref('carmen_sightings_indian') }}
)
, column_formatting as (    
    select 'Indian' as region
          ,cast(date_witness as date) as date_witness
          ,cast(witness as varchar) as witness
          ,cast(agent as varchar) as agent
          ,cast(date_agent as date) as date_agent
          ,cast(region_hq as varchar) as city_agent
          ,cast(country as varchar) as country
          ,cast(city as varchar) as city
          ,cast(latitude as float) as latitude
          ,cast(longitude as float) as longitude
          ,cast(has_weapon as boolean) as has_weapon
          ,cast(has_hat as boolean) as has_hat
          ,cast(has_jacket as boolean) as has_jacket
          ,cast(behavior as varchar) as behavior
      from carmen_sightings
)
select *
  from column_formatting