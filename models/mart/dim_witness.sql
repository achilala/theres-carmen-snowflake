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
, distinct_witness as (
  select witness
        ,city
        ,country
        ,region
        ,count(1) as num_of_sightings
    from carmen_sightings
   group by witness
        ,city
        ,country
        ,region
)
, hash_key as (
  select {{ dbt_utils.surrogate_key(['witness', 'city', 'country', 'region']) }} as dim_witness_key
        ,*
    from distinct_witness
)
, unknown_record as (
  select dim_witness_key
        ,witness
        ,city
        ,country
        ,region
        ,num_of_sightings
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