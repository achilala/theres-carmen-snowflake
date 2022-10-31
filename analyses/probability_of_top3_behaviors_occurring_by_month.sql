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
, sightings_by_behavior AS (
	SELECT behavior
		  ,SUM(f.num_of_sightings) AS total_sightings
	  FROM fct_sighting f
	 WHERE 1 = 1
	 GROUP BY behavior
)
, top3_occurring_behavior AS (
	SELECT behavior
		  ,1 AS behavior_score
	  FROM sightings_by_behavior
	 ORDER BY total_sightings DESC
	 LIMIT 3
)
, total_by_month AS (
	SELECT month_of_year
		  ,month_name
		  ,SUM(COALESCE(t3.behavior_score, 0)) AS total_of_top3_occurring_behavior
		  ,SUM(f.num_of_sightings) AS total_sightings
	  FROM fct_sighting f
	 INNER JOIN dim_date date_witness ON date_witness.dim_date_key = f.dim_date_witness_key
	  LEFT JOIN top3_occurring_behavior t3 ON t3.behavior = f.behavior
	 GROUP BY month_of_year
		  ,month_name
)
, behavior_probability AS (
	SELECT *
		  ,(total_of_top3_occurring_behavior * 1.0 / total_sightings) AS behavior_probability
	  FROM total_by_month
)
SELECT month_name
	  ,total_of_top3_occurring_behavior
	  ,total_sightings
	  ,behavior_probability
  FROM behavior_probability
 ORDER BY month_of_year