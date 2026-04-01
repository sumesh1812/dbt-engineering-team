select
    ID as account_id,
    NAME as account_name,
    INDUSTRY as industry,
    TYPE as account_type,
    OWNERID as owner_id,
    BILLINGCOUNTRY as billing_country,
    BILLINGCITY as billing_city,
    WEBSITE as website,
    PHONE as phone,
    ANNUALREVENUE as annual_revenue,
    NUMBEROFEMPLOYEES as number_of_employees,
    CREATEDDATE::timestamp_tz as created_at,
    LASTMODIFIEDDATE::timestamp_tz as updated_at
from {{ source('raw_salesforce', 'SF_ACCOUNTS') }}
