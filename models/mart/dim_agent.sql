{{ config(
    tags=["carmen_sightings", "mart"]
  )
}}

with carmen_sightings as (
  select *
    from {{ ref('int_carmen_sightings_unioned') }}
)
, ref_unknown_record as (
	select *
	  from {{ ref('ref_unknown_value') }}
)
, distinct_agent as (
  select agent
        ,city_agent as city
        ,country
        ,region
        ,count(1) as num_of_field_reports
    from carmen_sightings
   group by agent
        ,city_agent
        ,country
        ,region
)
, hash_key as (
  select {{ dbt_utils.surrogate_key(['agent', 'city', 'country', 'region']) }} as dim_agent_key
        ,*
    from distinct_agent
)
, unknown_record as (
  select dim_agent_key
        ,agent
        ,city
        ,country
        ,region
        ,num_of_field_reports
    from hash_key

      union all
      
  select unknown_key
        ,unknown_text
        ,unknown_text
        ,unknown_text
        ,unknown_text
        ,unknown_integer
    from ref_unknown_record
)
select *
  from unknown_record