{{ config(materialized='table') }}

-- depends_on: {{ ref('stg_citibike_202401') }}
-- depends_on: {{ ref('stg_citibike_202402') }}
-- depends_on: {{ ref('stg_citibike_202403') }}
-- depends_on: {{ ref('stg_citibike_202404') }}
-- depends_on: {{ ref('stg_citibike_202405') }}
-- depends_on: {{ ref('stg_citibike_202406') }}
-- depends_on: {{ ref('stg_citibike_202407') }}
-- depends_on: {{ ref('stg_citibike_202408') }}
-- depends_on: {{ ref('stg_citibike_202409') }}
-- depends_on: {{ ref('stg_citibike_202410') }}
-- depends_on: {{ ref('stg_citibike_202411') }}
-- depends_on: {{ ref('stg_citibike_202412') }}
-- depends_on: {{ ref('stg_citibike_202501') }}
-- depends_on: {{ ref('stg_citibike_202502') }}
-- depends_on: {{ ref('stg_citibike_202503') }}
-- depends_on: {{ ref('stg_citibike_202504') }}
-- depends_on: {{ ref('stg_citibike_202505') }}

{%- call statement('get_models', fetch_result=true) -%}
    SELECT table_name 
    FROM `{{ target.database }}`.`{{ target.schema }}`.INFORMATION_SCHEMA.TABLES 
    WHERE table_name LIKE 'stg_citibike_%'
      AND table_name NOT LIKE '%_clean'
      AND table_name NOT LIKE '%_errors'
      AND table_type = 'BASE TABLE'
    ORDER BY table_name
{%- endcall -%}

{%- set model_list = load_result('get_models') -%}
{%- set model_names = model_list['data'] | map('first') | list -%}

{{ log("Found models: " ~ model_names, info=True) }}

{% if model_names | length > 0 %}
    {% for model_name in model_names %}
        (
        {{ get_citibike_only_error_rows(model_name) }}
        ) 
        {% if not loop.last %} UNION ALL {% endif %}
    {% endfor %}
{% else %}
    SELECT 
        CAST(NULL AS STRING) AS ride_id,
        CAST(NULL AS STRING) AS error_reason,
        'No models found' AS source_model
    WHERE FALSE
{% endif %}