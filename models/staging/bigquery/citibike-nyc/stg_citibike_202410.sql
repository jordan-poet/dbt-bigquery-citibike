{{ config(materialized='table') }}

{{ clean_citibike_staging_nospace('citibike_nyc_2024', '202410-citibike-tripdata') }}