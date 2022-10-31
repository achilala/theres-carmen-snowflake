{{ config(
    tags=["carmen_sightings", "intermediate"]
  )
}}

with carmen_sightings as (
    select *
      from {{ ref('stg_carmen_sightings_africa') }}
    
    union all
    
    select *
      from {{ ref('stg_carmen_sightings_america') }}
    
    union all
    
    select *
      from {{ ref('stg_carmen_sightings_asia') }}
    
    union all
    
    select *
      from {{ ref('stg_carmen_sightings_atlantic') }}
    
    union all
    
    select *
      from {{ ref('stg_carmen_sightings_australia') }}
    
    union all
    
    select *
      from {{ ref('stg_carmen_sightings_europe') }}
    
    union all
    
    select *
      from {{ ref('stg_carmen_sightings_indian') }}
    
    union all
    
    select *
      from {{ ref('stg_carmen_sightings_pacific') }}
)
select *
  from carmen_sightings