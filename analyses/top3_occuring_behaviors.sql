{{ config(
    tags=["carmen_sightings", "analysis"]
  )
}}

with fct_sighting as (
	select *
	  from {{ ref('fct_sighting') }}
)
, sightings_by_behavior as (
	select behavior
		  ,sum(f.num_of_sightings) as total_sightings
	  from fct_sighting f
	 where 1 = 1
	 group by behavior
)
select *
  from sightings_by_behavior
 order by total_sightings desc
 limit 3