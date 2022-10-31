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
, hash_key as (
	select cast(strftime(date_witness, '%Y%m%d') as int) as dim_date_witness_key
          ,cast(strftime(date_agent, '%Y%m%d') as int) as dim_date_agent_key
          ,{{ dbt_utils.surrogate_key(['witness', 'city', 'country', 'region']) }} as dim_witness_key
          ,{{ dbt_utils.surrogate_key(['agent', 'city_agent', 'country', 'region']) }} as dim_agent_key
          ,{{ dbt_utils.surrogate_key(['latitude', 'longitude']) }} as dim_location_key
          ,behavior as behavior
          ,case
              when has_weapon then 1
              else 0
           end as has_weapon
          ,case
              when has_hat then 1
              else 0
           end as has_hat
          ,case
              when has_jacket then 1
              else 0
           end as has_jacket
          ,case
              when has_weapon and has_jacket and has_hat then 1
              else 0
           end as is_armed_has_jacket_has_hat
          ,case
              when has_weapon and has_jacket and not has_hat then 1
              else 0
           end as is_armed_has_jacket_no_hat
          ,case
              when has_weapon and not has_jacket and has_hat then 1
              else 0
           end as is_armed_no_jacket_has_hat
          ,case
              when has_weapon and not has_jacket and not has_hat then 1
              else 0
           end as is_armed_no_jacket_no_hat
          ,case
              when not has_weapon and has_jacket and has_hat then 1
              else 0
           end as is_unarmed_has_jacket_has_hat
          ,case
              when not has_weapon and has_jacket and not has_hat then 1
              else 0
           end as is_unarmed_has_jacket_no_hat
          ,case
              when not has_weapon and not has_jacket and has_hat then 1
              else 0
           end as is_unarmed_no_jacket_has_hat
          ,case
              when not has_weapon and not has_jacket and not has_hat then 1
              else 0
           end as is_unarmed_no_jacket_no_hat
          ,(date_agent - date_witness) as num_of_days_since_sighting
          ,1 as num_of_sightings
      from carmen_sightings
)
, unknown_key as (
    select coalesce(dim_date_witness_key, unknown_key::int) as dim_date_witness_key
          ,coalesce(dim_date_agent_key, unknown_key::int) as dim_date_agent_key
          ,coalesce(dim_witness_key, unknown_key) as dim_witness_key
          ,coalesce(dim_agent_key, unknown_key) as dim_agent_key
          ,coalesce(dim_location_key, unknown_key) as dim_location_key
          ,behavior
          ,has_weapon
          ,has_hat
          ,has_jacket
          ,is_armed_has_jacket_has_hat
          ,is_armed_has_jacket_no_hat
          ,is_armed_no_jacket_has_hat
          ,is_armed_no_jacket_no_hat
          ,is_unarmed_has_jacket_has_hat
          ,is_unarmed_has_jacket_no_hat
          ,is_unarmed_no_jacket_has_hat
          ,is_unarmed_no_jacket_no_hat
          ,num_of_days_since_sighting
          ,num_of_sightings
      from hash_key
      join ref_unknown_record on 1 = 1
)
select *
  from unknown_key