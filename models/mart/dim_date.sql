{{ config(
    tags=["carmen_sightings", "mart"]
  )
}}

-- still need to find out how to inject variables '{{ var("CALENDAR_START_DATE") }}' and '{{ var("CALENDAR_END_DATE") }}'
with date_spine as (
  {{ dbt_utils.date_spine(
      datepart="day",
      start_date="cast('1985-04-23' as date)",
      end_date="cast('2022-08-20' as date)"
    )
  }}
)
, ref_unknown_record as (
	select *
	  from {{ ref('ref_unknown_value') }}
)
, calendar as (
  select strftime(date_day, '%Y%m%d') as dim_date_key
        ,date_day
        ,strftime(date_day, '%m') as month_of_year
        ,strftime(date_day, '%B') as month_name
        ,strftime(date_day, '%b') as month_name_abbr
        ,strftime(date_day, '%Y') as year
    from date_spine
)
, unknown_record as (
    SELECT dim_date_key
          ,date_day
          ,month_of_year
          ,month_name
          ,month_name_abbr
          ,year
      from calendar

    union all
    
    select unknown_key::int
          ,null
          ,unknown_text
          ,unknown_text
          ,unknown_text
          ,unknown_integer
      from ref_unknown_record
)
select *
  from unknown_record
 order by dim_date_key