{{ config(materialized='table') }}

select 
    ride_id, 
    rideable_type, 
    started_at, 
    ended_at, 
    start_station_name, 
    start_station_id, 
    `end station_name` as end_station_name,
    end_station_id, 
    start_lat, 
    start_lng, 
    end_lat, 
    end_lng, 
    member_casual 
from {{source('citibike_nyc_2024', '202405-citibike-tripdata')}}