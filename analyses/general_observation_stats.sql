{{ config(
    tags=["carmen_sightings", "analysis"]
  )
}}

with fct_sighting as (
	select *
	  from {{ ref('fct_sighting') }}
)
, total_count as ( 
	select sum(has_weapon) as has_weapon
		  ,sum(has_hat) as has_hat
		  ,sum(has_jacket) as has_jacket
		  ,sum(is_armed_has_jacket_no_hat) as is_armed_has_jacket_no_hat
		  ,sum(is_armed_no_jacket_has_hat) as is_armed_no_jacket_has_hat
		  ,sum(is_armed_has_jacket_has_hat) as is_armed_has_jacket_has_hat
		  ,sum(is_armed_no_jacket_no_hat) as is_armed_no_jacket_no_hat
		  ,sum(is_unarmed_has_jacket_no_hat) as is_unarmed_has_jacket_no_hat
		  ,sum(is_unarmed_no_jacket_has_hat) as is_unarmed_no_jacket_has_hat
		  ,sum(is_unarmed_has_jacket_has_hat) as is_unarmed_has_jacket_has_hat
		  ,sum(is_unarmed_no_jacket_no_hat) as is_unarmed_no_jacket_no_hat
		  ,sum(num_of_sightings) as num_of_sightings
	  from fct_sighting
)
select num_of_sightings
	  ,has_weapon
	  ,(has_weapon * 1.0 / num_of_sightings) as has_weapon_probability
	  ,has_hat
	  ,(has_hat * 1.0 / num_of_sightings) as has_hat_probability
	  ,has_jacket
	  ,(has_jacket * 1.0 / num_of_sightings) as has_jacket_probability
	  ,is_armed_has_jacket_no_hat
	  ,(is_armed_has_jacket_no_hat * 1.0 / num_of_sightings) as is_armed_has_jacket_no_hat_probability
	  ,is_armed_no_jacket_has_hat
	  ,(is_armed_no_jacket_has_hat * 1.0 / num_of_sightings) as is_armed_no_jacket_has_hat_probability
	  ,is_armed_has_jacket_has_hat
	  ,(is_armed_has_jacket_has_hat * 1.0 / num_of_sightings) as is_armed_has_jacket_has_hat_probability
	  ,is_armed_no_jacket_no_hat
	  ,(is_armed_no_jacket_no_hat * 1.0 / num_of_sightings) as is_armed_no_jacket_no_hat_probability
	  ,is_unarmed_has_jacket_no_hat
	  ,(is_unarmed_has_jacket_no_hat * 1.0 / num_of_sightings) as is_unarmed_has_jacket_no_hat_probability
	  ,is_unarmed_no_jacket_has_hat
	  ,(is_unarmed_no_jacket_has_hat * 1.0 / num_of_sightings) as is_unarmed_no_jacket_has_hat_probability
	  ,is_unarmed_has_jacket_has_hat
	  ,(is_unarmed_has_jacket_has_hat * 1.0 / num_of_sightings) as is_unarmed_has_jacket_has_hat_probability
	  ,is_unarmed_no_jacket_no_hat
	  ,(is_unarmed_no_jacket_no_hat * 1.0 / num_of_sightings) as is_unarmed_no_jacket_no_hat_probability
  from total_count