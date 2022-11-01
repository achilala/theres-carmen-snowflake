{{ config(
    tags=["carmen_sightings", "analysis"]
  )
}}

with fct_sighting as (
	select *
	  from {{ ref('fct_sighting') }}
)
, dim_date as (
	select *
	  from {{ ref('dim_date') }}
)
, sightings_by_behavior as (
	select behavior
		  ,sum(f.num_of_sightings) as total_sightings
	  from fct_sighting f
	 where 1 = 1
	 group by behavior
)
, top3_occurring_behavior as (
	select behavior
		  ,1 as behavior_score
	  from sightings_by_behavior
	 order by total_sightings desc
	 limit 3
)
, total_by_month as (
	select month_of_year
		  ,month_name
		  ,sum(coalesce(t3.behavior_score, 0)) as total_of_top3_occurring_behavior
		  ,sum(f.num_of_sightings) as total_sightings
	  from fct_sighting f
	 inner join dim_date date_witness on date_witness.dim_date_key = f.dim_date_witness_key
	  left join top3_occurring_behavior t3 on t3.behavior = f.behavior
	 group by month_of_year
		  ,month_name
)
, behavior_probability as (
	select *
		  ,(total_of_top3_occurring_behavior * 1.0 / total_sightings) as behavior_probability
	  from total_by_month
)
select month_name
	  ,total_of_top3_occurring_behavior
	  ,total_sightings
	  ,behavior_probability
  from behavior_probability
 order by month_of_year