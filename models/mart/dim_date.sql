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
  select to_char(date_day, 'yyyyMMdd') as dim_date_key
        ,date_day
        ,to_char(date_day, 'MM') as month_of_year
        ,to_char(date_day, 'MMMM') as month_name
        ,to_char(date_day, 'MON') as month_name_abbr
        ,to_char(date_day, 'YYYY') as year
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