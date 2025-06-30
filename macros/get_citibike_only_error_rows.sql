{% macro get_citibike_only_error_rows(model_name) %}

WITH source_data AS (
    SELECT * FROM {{ ref(model_name) }}
),

-- Define your business rules for all citibike models
data_quality_checks AS (
    SELECT *,
        CASE 
            WHEN ended_at IS NOT NULL AND ended_at < started_at THEN 'invalid_trip_duration'
            WHEN end_station_name IS NOT NULL AND end_station_id IS NULL THEN 'missing_end_station_id'
            WHEN start_station_name IS NOT NULL AND start_station_id IS NULL THEN 'missing_start_station_id'
            WHEN ride_id IS NULL THEN 'missing_ride_id'
            WHEN started_at IS NULL THEN 'missing_started_at'
            WHEN start_station_name IS NULL THEN 'missing_start_station_name'
            WHEN start_station_id IS NULL THEN 'missing_start_station_id'
            WHEN start_lat IS NULL THEN 'missing_start_lat'
            WHEN start_lng IS NULL THEN 'missing_start_lng'
            WHEN end_station_id IS NULL AND end_station_name IS NOT NULL THEN 'inconsistent_end_station'
            WHEN member_casual IS NULL THEN 'missing_member_casual'
            ELSE NULL 
        END AS error_reason
    FROM source_data
),

-- ERROR ROWS ONLY
error_data AS (
    SELECT *
    FROM data_quality_checks
    WHERE error_reason IS NOT NULL
)

SELECT 
    error_data.*,
    '{{ model_name }}' AS source_model,
    REGEXP_EXTRACT('{{ model_name }}', r'(\d{6})') AS source_month,
    CURRENT_TIMESTAMP() AS error_detected_at
FROM error_data

{% endmacro %}