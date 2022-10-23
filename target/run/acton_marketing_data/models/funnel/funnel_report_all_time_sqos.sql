

  create  table "acton"."dbt_actonmarketing"."funnel_report_all_time_sqos__dbt_tmp"
  as (
    

WITH base AS (

    SELECT DISTINCT
        sqo_source_xf.opportunity_id AS sqo_id,
        CONCAT('https://acton.my.salesforce.com/',sqo_source_xf.opportunity_id) AS sqo_url,
        sqo_source_xf.discovery_date AS sqo_date,
        account_name,
        opportunity_name,
        type AS opp_type,
        owner_name,
        sdr_name,
        created_date,
        close_date,
        acv,
        CASE
        WHEN account_global_region IS null THEN 'blank'
        ELSE account_global_region
    END AS account_global_region,
    CASE
        WHEN company_size_rev IS null THEN 'blank'
        ELSE company_size_rev
    END AS company_size_rev,
    CASE
        WHEN opp_lead_source IS null THEN 'blank'
        ELSE opp_lead_source
    END AS opp_lead_source,
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
        WHEN opp_offer_asset_name_lead_creation IS null THEN 'blank'
        ELSE opp_offer_asset_name_lead_creation
    END AS offer_asset_name_lead_creation
    FROM "acton"."dbt_actonmarketing"."sqo_source_xf"

)

SELECT *
FROM base
  );