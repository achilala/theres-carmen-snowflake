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
, dim_location AS (
	SELECT *
	  FROM {{ ref('dim_location') }}
)
, sightings_by_month AS (
	SELECT month_of_year
		  ,month_name
		  ,region
		  ,SUM(f.num_of_sightings) AS total_sightings
	  FROM fct_sighting f
	 INNER JOIN dim_date date_witness ON date_witness.dim_date_key = f.dim_date_witness_key
	 INNER JOIN dim_location l ON l.dim_location_key = f.dim_location_key
	 GROUP BY month_of_year
		  ,month_name
		  ,region
)
, sighting_rank AS (
	SELECT *
		  ,SUM(total_sightings) OVER (PARTITION BY month_name) AS month_total_sightings
		  ,ROW_NUMBER() OVER (PARTITION BY month_name ORDER BY total_sightings DESC) AS sighting_rank
	  FROM sightings_by_month
)
, sighting_probability AS (
	SELECT *
		  ,(total_sightings / month_total_sightings) AS sighting_probability
	  FROM sighting_rank
	 WHERE 1 = 1
	   AND sighting_rank = 1
)
SELECT month_name
	  ,region
	  ,total_sightings
	  ,month_total_sightings
	  ,sighting_probability
  FROM sighting_probability
 ORDER BY month_of_year