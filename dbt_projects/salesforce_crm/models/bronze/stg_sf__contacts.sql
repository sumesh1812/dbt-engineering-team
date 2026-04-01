select
    ID::VARCHAR as contact_id,
    FIRSTNAME::VARCHAR as first_name,
    LASTNAME::VARCHAR as last_name,
    EMAIL::VARCHAR as email,
    PHONE::VARCHAR as phone,
    TITLE::VARCHAR as title,
    DEPARTMENT::VARCHAR as department,
    ACCOUNTID::VARCHAR as account_id,
    MAILINGCITY::VARCHAR as mailing_city,
    MAILINGCOUNTRY::VARCHAR as mailing_country,
    LEADSOURCE::VARCHAR as lead_source,
    OWNERID::VARCHAR as owner_id,
    CREATEDDATE::TIMESTAMP_TZ as created_at,
    LASTMODIFIEDDATE::TIMESTAMP_TZ as updated_at,
    current_timestamp()::TIMESTAMP_TZ as _loaded_at
from {{ source('raw_salesforce', 'SF_CONTACTS') }}
