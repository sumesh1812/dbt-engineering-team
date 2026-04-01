select
    ID as contact_id,
    ACCOUNTID as account_id,
    FIRSTNAME as first_name,
    LASTNAME as last_name,
    EMAIL as email,
    PHONE as phone,
    TITLE as title,
    DEPARTMENT as department,
    MAILINGCITY as mailing_city,
    MAILINGCOUNTRY as mailing_country,
    OWNERID as owner_id,
    LEADSOURCE as lead_source,
    CREATEDDATE as created_at,
    LASTMODIFIEDDATE as updated_at,
    current_timestamp() as _brz_loaded_at,
    'ANALYTICS.RAW.SF_CONTACTS' as _brz_source_table
from {{ source('raw_salesforce', 'SF_CONTACTS') }}
