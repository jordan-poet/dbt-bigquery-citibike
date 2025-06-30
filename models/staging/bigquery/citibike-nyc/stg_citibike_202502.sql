{{ config(materialized='table') }}

{{ clean_citibike_staging_nospace('citibike_nyc_2025', '202502-citibike-tripdata') }}