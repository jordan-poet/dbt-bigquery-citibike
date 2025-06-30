{{ config(materialized='table') }}

{{ clean_citibike_staging_nospace('citibike_nyc_2025', '202501-citibike-tripdata') }}