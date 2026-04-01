select
    ID as opportunity_id,
    NAME as opportunity_name,
    ACCOUNTID as account_id,
    OWNERID as owner_id,
    AMOUNT as amount,
    STAGENAME as stage_name,
    TYPE as opportunity_type,
    PROBABILITY as probability,
    FORECASTCATEGORY as forecast_category,
    LEADSOURCE as lead_source,
    CLOSEDATE::date as close_date,
    ISCLOSED as is_closed,
    ISWON as is_won,
    CREATEDDATE::timestamp_tz as created_at,
    LASTMODIFIEDDATE::timestamp_tz as updated_at
from {{ source('raw_salesforce', 'SF_OPPORTUNITIES') }}
