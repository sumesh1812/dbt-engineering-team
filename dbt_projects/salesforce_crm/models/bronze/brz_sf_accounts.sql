select
    ID as account_id,
    NAME as account_name,
    INDUSTRY as industry,
    TYPE as account_type,
    BILLINGCOUNTRY as billing_country,
    BILLINGCITY as billing_city,
    PHONE as phone,
    WEBSITE as website,
    OWNERID as owner_id,
    NUMBEROFEMPLOYEES as number_of_employees,
    ANNUALREVENUE as annual_revenue,
    CREATEDDATE as created_at,
    LASTMODIFIEDDATE as updated_at,
    current_timestamp() as _brz_loaded_at,
    'ANALYTICS.RAW.SF_ACCOUNTS' as _brz_source_table
from {{ source('raw_salesforce', 'SF_ACCOUNTS') }}
