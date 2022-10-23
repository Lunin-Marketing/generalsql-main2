{{ config(materialized='table') }}

SELECT
    segment,
    lead_source,
    global_region,
    'Inquiries' AS type,
    month,
    quarter,
    COUNT(*) AS records
FROM {{ref('funnel_report_all_time_leads')}}
LEFT JOIN {{ref('date_base_xf')}} ON
funnel_report_all_time_leads.created_date=date_base_xf.day
WHERE created_date >= '2021-01-01'
AND lead_source IN ('Marketing','Sales','SDR','Channel')
GROUP BY 1,2,3,4,5,6
ORDER BY 1,2,3,4,5,6