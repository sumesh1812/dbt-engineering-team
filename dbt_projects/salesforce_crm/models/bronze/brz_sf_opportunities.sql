select
    ID as opportunity_id,
    NAME as opportunity_name,
    ACCOUNTID as account_id,
    OWNERID as owner_id,
    TYPE as opportunity_type,
    STAGENAME as stage_name,
    FORECASTCATEGORY as forecast_category,
    AMOUNT as amount,
    PROBABILITY as probability,
    CLOSEDATE as close_date,
    ISCLOSED as is_closed,
    ISWON as is_won,
    LEADSOURCE as lead_source,
    CREATEDDATE as created_at,
    LASTMODIFIEDDATE as updated_at,
    current_timestamp() as _brz_loaded_at,
    'ANALYTICS.RAW.SF_OPPORTUNITIES' as _brz_source_table
from {{ source('raw_salesforce', 'SF_OPPORTUNITIES') }}
