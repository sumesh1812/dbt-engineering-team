select
    trim(id) as contact_id,
    trim(firstname) as first_name,
    trim(lastname) as last_name,
    lower(trim(email)) as email,
    trim(phone) as phone,
    trim(title) as title,
    trim(department) as department,
    trim(accountid) as account_id,
    trim(leadsource) as lead_source,
    trim(mailingcity) as mailing_city,
    trim(mailingcountry) as mailing_country,
    trim(ownerid) as owner_id,
    cast(createddate as timestamp_tz) as created_at,
    cast(lastmodifieddate as timestamp_tz) as modified_at,
    current_timestamp() as _loaded_at,
    'ANALYTICS.RAW.SF_CONTACTS' as _source_table
from {{ source('raw_salesforce', 'SF_CONTACTS') }}
