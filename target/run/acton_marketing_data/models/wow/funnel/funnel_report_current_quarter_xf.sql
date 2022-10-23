

  create  table "acton"."dbt_actonmarketing"."funnel_report_current_quarter_xf__dbt_tmp"
  as (
    

WITH base AS (

    SELECT
        COUNT(DISTINCT lead_id) AS leads,
        0 AS mqls,
        0 AS sals,
        0 AS sqls,
        0 AS sqos,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_leads"
    GROUP BY 2,3,4,5,6
    UNION ALL
    SELECT
        0 AS leads,
        COUNT(DISTINCT mql_id) AS mqls,
        0 AS sals,
        0 AS sqls,
        0 AS sqos,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_mqls"
    GROUP BY 1,3,4,5,6
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        COUNT(DISTINCT sal_id) AS sals,
        0 AS sqls,
        0 AS sqos,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_sals"
    GROUP BY 1,2,4,5,6
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        0 AS sals,
        COUNT(DISTINCT sql_id) AS sqls,
        0 AS sqos,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_sqls"
    GROUP BY 1,2,3,5,6
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        0 AS sals,
        0 AS sqls,
        COUNT(DISTINCT sqo_id) AS sqos,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_sqos"
    GROUP BY 1,2,4,3,6
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        0 AS sals,
        0 AS sqls,
        0 AS sqos,
        COUNT(DISTINCT won_id) AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_won"
    GROUP BY 1,2,4,5,3

)

SELECT
    SUM(leads) AS leads,
    SUM(mqls) AS mqls,
    SUM(sals) AS sals,
    SUM(sqls) AS sqls,
    SUM(sqos) AS sqos,
    SUM(won) AS won
FROM base
  );