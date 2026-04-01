select
    trim(id) as account_id,
    trim(name) as account_name,
    trim(type) as account_type,
    trim(industry) as industry,
    cast(annualrevenue as number(18,2)) as annual_revenue,
    cast(numberofemployees as integer) as number_of_employees,
    trim(phone) as phone,
    trim(website) as website,
    trim(billingcity) as billing_city,
    trim(billingcountry) as billing_country,
    trim(ownerid) as owner_id,
    cast(createddate as timestamp_tz) as created_at,
    cast(lastmodifieddate as timestamp_tz) as modified_at,
    current_timestamp() as _loaded_at,
    'ANALYTICS.RAW.SF_ACCOUNTS' as _source_table
from {{ source('raw_salesforce', 'SF_ACCOUNTS') }}
