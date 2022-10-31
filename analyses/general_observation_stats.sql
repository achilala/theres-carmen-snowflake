{{ config(
    tags=["carmen_sightings", "analysis"]
  )
}}

WITH fct_sighting AS (
	SELECT *
	  FROM {{ ref('fct_sighting') }}
)
, total_count AS ( 
	SELECT SUM(has_weapon) AS has_weapon
		  ,SUM(has_hat) AS has_hat
		  ,SUM(has_jacket) AS has_jacket
		  ,SUM(is_armed_has_jacket_no_hat) AS is_armed_has_jacket_no_hat
		  ,SUM(is_armed_no_jacket_has_hat) AS is_armed_no_jacket_has_hat
		  ,SUM(is_armed_has_jacket_has_hat) AS is_armed_has_jacket_has_hat
		  ,SUM(is_armed_no_jacket_no_hat) AS is_armed_no_jacket_no_hat
		  ,SUM(is_unarmed_has_jacket_no_hat) AS is_unarmed_has_jacket_no_hat
		  ,SUM(is_unarmed_no_jacket_has_hat) AS is_unarmed_no_jacket_has_hat
		  ,SUM(is_unarmed_has_jacket_has_hat) AS is_unarmed_has_jacket_has_hat
		  ,SUM(is_unarmed_no_jacket_no_hat) AS is_unarmed_no_jacket_no_hat
		  ,SUM(num_of_sightings) AS num_of_sightings
	  FROM fct_sighting
)
SELECT num_of_sightings
	  ,has_weapon
	  ,(has_weapon * 1.0 / num_of_sightings) AS has_weapon_probability
	  ,has_hat
	  ,(has_hat * 1.0 / num_of_sightings) AS has_hat_probability
	  ,has_jacket
	  ,(has_jacket * 1.0 / num_of_sightings) AS has_jacket_probability
	  ,is_armed_has_jacket_no_hat
	  ,(is_armed_has_jacket_no_hat * 1.0 / num_of_sightings) AS is_armed_has_jacket_no_hat_probability
	  ,is_armed_no_jacket_has_hat
	  ,(is_armed_no_jacket_has_hat * 1.0 / num_of_sightings) AS is_armed_no_jacket_has_hat_probability
	  ,is_armed_has_jacket_has_hat
	  ,(is_armed_has_jacket_has_hat * 1.0 / num_of_sightings) AS is_armed_has_jacket_has_hat_probability
	  ,is_armed_no_jacket_no_hat
	  ,(is_armed_no_jacket_no_hat * 1.0 / num_of_sightings) AS is_armed_no_jacket_no_hat_probability
	  ,is_unarmed_has_jacket_no_hat
	  ,(is_unarmed_has_jacket_no_hat * 1.0 / num_of_sightings) AS is_unarmed_has_jacket_no_hat_probability
	  ,is_unarmed_no_jacket_has_hat
	  ,(is_unarmed_no_jacket_has_hat * 1.0 / num_of_sightings) AS is_unarmed_no_jacket_has_hat_probability
	  ,is_unarmed_has_jacket_has_hat
	  ,(is_unarmed_has_jacket_has_hat * 1.0 / num_of_sightings) AS is_unarmed_has_jacket_has_hat_probability
	  ,is_unarmed_no_jacket_no_hat
	  ,(is_unarmed_no_jacket_no_hat * 1.0 / num_of_sightings) AS is_unarmed_no_jacket_no_hat_probability
  FROM total_count