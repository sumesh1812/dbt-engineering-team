select
    ID as contact_id,
    ACCOUNTID as account_id,
    OWNERID as owner_id,
    FIRSTNAME as first_name,
    LASTNAME as last_name,
    EMAIL as email,
    PHONE as phone,
    TITLE as title,
    DEPARTMENT as department,
    LEADSOURCE as lead_source,
    MAILINGCITY as mailing_city,
    MAILINGCOUNTRY as mailing_country,
    CREATEDDATE::timestamp_tz as created_at,
    LASTMODIFIEDDATE::timestamp_tz as updated_at
from {{ source('raw_salesforce', 'SF_CONTACTS') }}
