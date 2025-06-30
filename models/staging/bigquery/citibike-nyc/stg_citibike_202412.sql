{{ config(materialized='table') }}

{{ clean_citibike_staging_nospace('citibike_nyc_2024', '202412-citibike-tripdata') }}