{{ config(materialized='table') }}

WITH base AS (

    SELECT DISTINCT
        lead_mql_source_xf.person_id AS mql_id,
        CONCAT('https://acton.my.salesforce.com/',lead_mql_source_xf.person_id) AS mql_url,
        lead_mql_source_xf.mql_most_recent_date AS mql_date,
        lead_mql_source_xf.working_date,
        company,
        first_name,
        last_name,
        title,
        person_status,
        country,
        is_hand_raiser,
        CASE 
            WHEN working_date IS null then 'No'
            ELSE 'Yes'
        END AS is_working,
        CASE
            WHEN global_region IS null THEN 'blank'
            ELSE global_region
        END AS global_region,
        CASE
            WHEN company_size_rev IS null THEN 'blank'
            ELSE company_size_rev
        END AS company_size_rev,
        CASE
            WHEN lead_source IS null THEN 'blank'
            ELSE lead_source
        END AS lead_source,
        CASE
            WHEN segment IS null THEN 'blank'
            ELSE segment
        END AS segment,
        CASE
            WHEN industry IS null THEN 'blank'
            ELSE industry
        END AS industry,
        CASE
            WHEN industry_bucket IS null THEN 'blank'
            ELSE industry_bucket
        END AS industry_bucket,
        CASE
            WHEN channel_bucket IS null THEN 'blank'
            ELSE channel_bucket
        END AS channel_bucket,
        CASE
            WHEN offer_asset_name_lead_creation IS null THEN 'blank'
            ELSE offer_asset_name_lead_creation
        END AS offer_asset_name_lead_creation,
        CASE
            WHEN campaign_lead_creation IS null THEN 'blank'
            ELSE campaign_lead_creation
        END AS campaign_lead_creation
    FROM {{ref('lead_mql_source_xf')}}

)

SELECT *
FROM base