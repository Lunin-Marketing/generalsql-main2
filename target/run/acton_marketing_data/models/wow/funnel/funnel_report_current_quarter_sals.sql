

  create  table "acton"."dbt_actonmarketing"."funnel_report_current_quarter_sals__dbt_tmp"
  as (
    

WITH current_quarter AS (

    SELECT
        fy,
        quarter 
    FROM "acton"."dbt_actonmarketing"."date_base_xf"
    WHERE day=CURRENT_DATE

), base AS (

    SELECT DISTINCT
        sal_source_xf.person_id AS sal_id,
        sal_source_xf.working_date AS sal_date,
        week,
        global_region
    FROM "acton"."dbt_actonmarketing"."sal_source_xf"
    LEFT JOIN "acton"."dbt_actonmarketing"."date_base_xf" ON
    sal_source_xf.working_date=date_base_xf.day
    LEFT JOIN current_quarter ON 
    date_base_xf.quarter=current_quarter.quarter
    WHERE current_quarter.quarter IS NOT null

)

SELECT *
FROM base
  );