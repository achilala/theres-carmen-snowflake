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
, total_by_month as (
	select month_of_year
		  ,month_name
		  ,sum(is_armed_has_jacket_no_hat) as total_is_armed_has_jacket_no_hat
		  ,sum(f.num_of_sightings) as total_sightings
	  from fct_sighting f
	 inner join dim_date date_witness on date_witness.dim_date_key = f.dim_date_witness_key
	 group by month_of_year
		  ,month_name
)
, behavior_probability as (
	select *
		  ,(total_is_armed_has_jacket_no_hat * 1.0 / total_sightings) as behavior_probability
	  from total_by_month
)
select month_name
	  ,total_is_armed_has_jacket_no_hat
	  ,total_sightings
	  ,behavior_probability
  from behavior_probability
 order by month_of_year