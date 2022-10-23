

WITH rolling_3mo AS (

    SELECT DISTINCT
        week
    FROM "acton"."dbt_actonmarketing"."date_base_xf"
    WHERE day >= CURRENT_DATE-90
    AND day <= CURRENT_DATE
    ORDER BY 1

), base AS (

    SELECT DISTINCT
        sql_source_xf.sql_id AS sql_id,
        sql_source_xf.created_date AS created_date,
        rolling_3mo.week,
        account_global_region
    FROM "acton"."dbt_actonmarketing"."sql_source_xf"
    LEFT JOIN "acton"."dbt_actonmarketing"."date_base_xf" ON
    sql_source_xf.created_date=date_base_xf.day
    LEFT JOIN rolling_3mo ON 
    date_base_xf.week=rolling_3mo.week
    WHERE rolling_3mo.week IS NOT null

)

SELECT *
FROM base