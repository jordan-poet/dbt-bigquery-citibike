select 
    CAST(ride_id AS STRING) as ride_id, 
    CAST(rideable_type AS STRING) as rideable_type, 
    CAST(started_at AS TIMESTAMP) as started_at, 
    CAST(ended_at AS TIMESTAMP) as ended_at, 
    CAST(start_station_name AS STRING) as start_station_name, 
    CAST(start_station_id AS STRING) as start_station_id, 
    CAST(end_station_name AS STRING) as end_station_name, 
    CAST(end_station_id AS STRING) as end_station_id, 
    CAST(start_lat AS NUMERIC) as start_lat, 
    CAST(start_lng AS NUMERIC) as start_lng, 
    CAST(end_lat AS NUMERIC) as end_lat, 
    CAST(end_lng AS NUMERIC) as end_lng, 
    CAST(member_casual AS STRING) as member_casual
from {{ source('citibike_nyc_2025', '202505-citibike-tripdata') }} 