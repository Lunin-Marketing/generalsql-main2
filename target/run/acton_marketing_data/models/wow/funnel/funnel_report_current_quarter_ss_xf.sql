

  create  table "acton"."dbt_actonmarketing"."funnel_report_current_quarter_ss_xf__dbt_tmp"
  as (
    

WITH base AS (

    SELECT
        COUNT(DISTINCT lead_id) AS leads,
        0 AS mqls,
        0 AS sals,
        0 AS sqls,
        0 AS sqos,
        0 AS demos,
        0 AS voc,
        0 AS closing,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_leads_ss"
    GROUP BY 2,3,4,5,6,7,8,9
    UNION ALL
    SELECT
        0 AS leads,
        COUNT(DISTINCT mql_id) AS mqls,
        0 AS sals,
        0 AS sqls,
        0 AS sqos,
        0 AS demos,
        0 AS voc,
        0 AS closing,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_mqls_ss"
    GROUP BY 1,3,4,5,6,7,8,9
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        COUNT(DISTINCT sal_id) AS sals,
        0 AS sqls,
        0 AS sqos,
        0 AS demos,
        0 AS voc,
        0 AS closing,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_sals_ss"
    GROUP BY 1,2,4,5,6,7,8,9
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        0 AS sals,
        COUNT(DISTINCT sql_id) AS sqls,
        0 AS sqos,
        0 AS demos,
        0 AS voc,
        0 AS closing,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_sqls_ss"
    GROUP BY 1,2,3,5,6,7,8,9
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        0 AS sals,
        0 AS sqls,
        COUNT(DISTINCT sqo_id) AS sqos,
        0 AS demos,
        0 AS voc,
        0 AS closing,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_sqos_ss"
    GROUP BY 1,2,3,4,6,7,8,9
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        0 AS sals,
        0 AS sqls,
        0 AS sqos,
        COUNT(DISTINCT demo_id) AS demos,
        0 AS voc,
        0 AS closing,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_demo_ss"
    GROUP BY 1,2,3,4,5,7,8,9
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        0 AS sals,
        0 AS sqls,
        0 AS sqos,
        0 AS demos,
        COUNT(DISTINCT voc_id) AS voc,
        0 AS closing,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_voc_ss"
    GROUP BY 1,2,3,4,5,6,8,9
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        0 AS sals,
        0 AS sqls,
        0 AS sqos,
        0 AS demos,
        0 AS voc,
        COUNT(DISTINCT closing_id) AS closing,
        0 AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_closing_ss"
    GROUP BY 1,2,3,4,5,6,7,9
    UNION ALL
    SELECT
        0 AS leads,
        0 AS mqls,
        0 AS sals,
        0 AS sqls,
        0 AS sqos,
        0 AS demos,
        0 AS voc,
        0 AS closing,
        COUNT(DISTINCT won_id) AS won
    FROM "acton"."dbt_actonmarketing"."funnel_report_current_quarter_won"
    GROUP BY 1,2,3,4,5,6,7,8

)

SELECT
    SUM(leads) AS leads,
    SUM(mqls) AS mqls,
    SUM(sals) AS sals,
    SUM(sqls) AS sqls,
    SUM(sqos) AS sqos,
    SUM(demos) AS demos,
    SUM(voc) AS voc,
    SUM(closing) AS closing,
    SUM(won) AS won
FROM base
  );