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
, dim_location as (
	select *
	  from {{ ref('dim_location') }}
)
, sightings_by_month as (
	select month_of_year
		  ,month_name
		  ,region
		  ,sum(f.num_of_sightings) as total_sightings
	  from fct_sighting f
	 inner join dim_date date_witness on date_witness.dim_date_key = f.dim_date_witness_key
	 inner join dim_location l on l.dim_location_key = f.dim_location_key
	 group by month_of_year
		  ,month_name
		  ,region
)
, sighting_rank as (
	select *
		  ,sum(total_sightings) over (partition by month_name) as month_total_sightings
		  ,row_number() over (partition by month_name order by total_sightings desc) as sighting_rank
	  from sightings_by_month
)
, sighting_probability as (
	select *
		  ,(total_sightings / month_total_sightings) as sighting_probability
	  from sighting_rank
	 where 1 = 1
	   and sighting_rank = 1
)
select month_name
	  ,region
	  ,total_sightings
	  ,month_total_sightings
	  ,sighting_probability
  from sighting_probability
 order by month_of_year