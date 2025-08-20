-- cleans citibike data during ingestion using safecasting
-- this is for the files with the space in end_station_name column header

{% macro clean_citibike_staging(table_name) %}

SELECT 
    SAFE_CAST(ride_id AS STRING) AS ride_id, 
    SAFE_CAST(rideable_type AS STRING) AS rideable_type, 
    SAFE_CAST(started_at AS TIMESTAMP) AS started_at, 
    SAFE_CAST(ended_at AS TIMESTAMP) AS ended_at, 
    SAFE_CAST(start_station_name AS STRING) AS start_station_name, 
    SAFE_CAST(start_station_id AS STRING) AS start_station_id, 
    SAFE_CAST(`end station_name` AS STRING) AS end_station_name, 
    SAFE_CAST(end_station_id AS STRING) AS end_station_id, 
    SAFE_CAST(start_lat AS FLOAT64) AS start_lat, 
    SAFE_CAST(start_lng AS FLOAT64) AS start_lng, 
    SAFE_CAST(end_lat AS FLOAT64) AS end_lat, 
    SAFE_CAST(end_lng AS FLOAT64) AS end_lng, 
    SAFE_CAST(member_casual AS STRING) AS member_casual
FROM {{ ref(table_name) }}
WHERE ride_id IS NOT NULL
  AND SAFE_CAST(started_at AS TIMESTAMP) IS NOT NULL

{% endmacro %}