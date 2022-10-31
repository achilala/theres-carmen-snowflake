{{ config(
    tags=["carmen_sightings", "intermediate"]
  )
}}

with unknown_value as (
    select cast('-1' as varchar) as unknown_key
          ,cast('Unknown' as varchar) as unknown_text
          ,cast(0 as int) as unknown_integer
          ,cast(0.0 as float) as unknown_float
          ,cast(false as boolean) as unknown_boolean
          ,cast('1900-01-01' as date) as unknown_date
          ,null as unknown_null
)
select *
  from unknown_value