{{ config(materialized='table') }}

WITH base AS (

    SELECT 
        lead_history_xf.lead_id,
        lead_history_xf.field_modified_at,
        lead_history_xf.field,
        lead_history_xf.old_value,
        lead_history_xf.new_value,
        'lead' AS type
    FROM {{ref('lead_history_xf')}}
    LEFT JOIN {{ref('lead_source_xf')}} ON 
    lead_history_xf.lead_id=lead_source_xf.lead_id
    WHERE working_date IS null
    UNION ALL
    SELECT 
        contact_history_xf.contact_id,
        contact_history_xf.field_modified_at,
        contact_history_xf.field,
        contact_history_xf.old_value,
        contact_history_xf.new_value,
        'contact' AS type
    FROM {{ref('contact_history_xf')}}
    LEFT JOIN {{ref('contact_source_xf')}} ON 
    contact_history_xf.contact_id=contact_source_xf.contact_id
    WHERE working_date IS null

), final AS (

    SELECT
        lead_id,
        old_value,
        new_value,
        field_modified_at,
        type,
        ROW_NUMBER() OVER(PARTITION BY lead_id ORDER BY field_modified_at) AS event_number
    FROM base 
    WHERE field = 'Status'
    AND new_value = 'Working'
    ORDER BY lead_id,field_modified_at

)

SELECT 
    lead_id,
    old_value,
    new_value,
    field_modified_at,
    type
FROM final
WHERE event_number = 1