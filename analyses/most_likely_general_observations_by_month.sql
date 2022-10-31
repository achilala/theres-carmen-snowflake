{{ config(
    tags=["carmen_sightings", "analysis"]
  )
}}

WITH fct_sighting AS (
	SELECT *
	  FROM {{ ref('fct_sighting') }}
)
, dim_date AS (
	SELECT *
	  FROM {{ ref('dim_date') }}
)
, total_by_month AS (
	SELECT month_of_year
		  ,month_name
		  ,SUM(is_armed_has_jacket_no_hat) AS total_is_armed_has_jacket_no_hat
		  ,SUM(f.num_of_sightings) AS total_sightings
	  FROM fct_sighting f
	 INNER JOIN dim_date date_witness ON date_witness.dim_date_key = f.dim_date_witness_key
	 GROUP BY month_of_year
		  ,month_name
)
, behavior_probability AS (
	SELECT *
		  ,(total_is_armed_has_jacket_no_hat * 1.0 / total_sightings) AS behavior_probability
	  FROM total_by_month
)
SELECT month_name
	  ,total_is_armed_has_jacket_no_hat
	  ,total_sightings
	  ,behavior_probability
  FROM behavior_probability
 ORDER BY month_of_year