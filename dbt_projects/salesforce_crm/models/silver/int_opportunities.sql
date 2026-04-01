select
    opportunity_id,
    account_id,
    trim(opportunity_name) as opportunity_name,
    coalesce(amount, 0) as amount,
    coalesce(amount, 0) * (coalesce(probability, 0) / 100) as weighted_amount,
    trim(stage_name) as stage_name,
    coalesce(probability, 0) as probability,
    trim(forecast_category) as forecast_category,
    trim(opportunity_type) as opportunity_type,
    trim(lead_source) as lead_source,
    is_closed,
    is_won,
    is_closed and not is_won as is_lost,
    not is_closed as is_open,
    case
        when is_won then 'Won'
        when is_closed and not is_won then 'Lost'
        else 'Open'
    end as opportunity_status,
    close_date,
    case
        when is_closed and close_date is not null
        then datediff(day, created_at, close_date)
        else null
    end as days_to_close,
    date_trunc('month', close_date) as close_month,
    date_trunc('quarter', close_date) as close_quarter,
    extract(year from close_date) as close_year,
    owner_id,
    created_at,
    updated_at,
    {{ dbt_utils.generate_surrogate_key(['opportunity_id']) }} as opportunity_key,
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key
from {{ ref('stg_sf__opportunities') }}
