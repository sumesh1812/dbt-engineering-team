select
    ID::VARCHAR as account_id,
    NAME::VARCHAR as account_name,
    ANNUALREVENUE::NUMBER(18,2) as annual_revenue,
    PHONE::VARCHAR as phone,
    NUMBEROFEMPLOYEES::INTEGER as number_of_employees,
    BILLINGCITY::VARCHAR as billing_city,
    BILLINGCOUNTRY::VARCHAR as billing_country,
    INDUSTRY::VARCHAR as industry,
    TYPE::VARCHAR as account_type,
    WEBSITE::VARCHAR as website,
    OWNERID::VARCHAR as owner_id,
    CREATEDDATE::TIMESTAMP_TZ as created_at,
    LASTMODIFIEDDATE::TIMESTAMP_TZ as updated_at,
    current_timestamp()::TIMESTAMP_TZ as _loaded_at
from {{ source('raw_salesforce', 'SF_ACCOUNTS') }}
