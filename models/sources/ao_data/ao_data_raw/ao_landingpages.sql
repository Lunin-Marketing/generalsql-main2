{{ config(materialized='table') }}

WITH base AS (

    SELECT *
    FROM {{ source('data_studio_s3', 'data_studio_landingpages') }}

)

SELECT *
FROM base