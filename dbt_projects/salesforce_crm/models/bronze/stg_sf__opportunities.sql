select
    ID::VARCHAR as opportunity_id,
    NAME::VARCHAR as opportunity_name,
    ACCOUNTID::VARCHAR as account_id,
    AMOUNT::NUMBER(18,2) as amount,
    STAGENAME::VARCHAR as stage_name,
    PROBABILITY::NUMBER(5,2) as probability,
    FORECASTCATEGORY::VARCHAR as forecast_category,
    TYPE::VARCHAR as opportunity_type,
    LEADSOURCE::VARCHAR as lead_source,
    ISCLOSED::BOOLEAN as is_closed,
    ISWON::BOOLEAN as is_won,
    CLOSEDATE::DATE as close_date,
    OWNERID::VARCHAR as owner_id,
    CREATEDDATE::TIMESTAMP_TZ as created_at,
    LASTMODIFIEDDATE::TIMESTAMP_TZ as updated_at,
    current_timestamp()::TIMESTAMP_TZ as _loaded_at
from {{ source('raw_salesforce', 'SF_OPPORTUNITIES') }}
