
  
    

  create  table "acton"."Postgres"."ao_media_xf__dbt_tmp"
  as (
    

SELECT 
-- IDs
    document_id AS media_id,
    e_mail_address AS email,
    record_id,
    unique_visitor_id,

-- Media Attributes
    document_name AS media_name,
    
-- Action Data
    action,
    action_time,
    action_day,

-- Other Data
    cookie_id,
    ip_address,
    e_mail_domain AS email_domain
FROM "acton"."Postgres"."ao_media"
WHERE e_mail_address IS NOT null
AND e_mail_address NOT LIKE 'unknown%'
  );
  