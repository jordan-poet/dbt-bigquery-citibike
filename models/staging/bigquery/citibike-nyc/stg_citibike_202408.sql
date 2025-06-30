{{ config(materialized='table') }}

{{ clean_citibike_staging('citibike_nyc_2024', '202408-citibike-tripdata') }}