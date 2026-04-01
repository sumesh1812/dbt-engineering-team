select
    trim(id) as opportunity_id,
    trim(name) as opportunity_name,
    trim(accountid) as account_id,
    coalesce(cast(amount as number(18,2)), 0) as amount,
    trim(stagename) as stage_name,
    cast(probability as number(5,2)) as probability,
    trim(forecastcategory) as forecast_category,
    trim(type) as opportunity_type,
    trim(leadsource) as lead_source,
    cast(closedate as date) as close_date,
    cast(isclosed as boolean) as is_closed,
    cast(iswon as boolean) as is_won,
    trim(ownerid) as owner_id,
    cast(createddate as timestamp_tz) as created_at,
    cast(lastmodifieddate as timestamp_tz) as modified_at,
    current_timestamp() as _loaded_at,
    'ANALYTICS.RAW.SF_OPPORTUNITIES' as _source_table
from {{ source('raw_salesforce', 'SF_OPPORTUNITIES') }}
