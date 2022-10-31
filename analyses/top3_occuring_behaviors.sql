{{ config(
    tags=["carmen_sightings", "analysis"]
  )
}}

WITH fct_sighting AS (
	SELECT *
	  FROM {{ ref('fct_sighting') }}
)
, sightings_by_behavior AS (
	SELECT behavior
		  ,SUM(f.num_of_sightings) AS total_sightings
	  FROM fct_sighting f
	 WHERE 1 = 1
	 GROUP BY behavior
)
SELECT *
  FROM sightings_by_behavior
 ORDER BY total_sightings DESC
 LIMIT 3