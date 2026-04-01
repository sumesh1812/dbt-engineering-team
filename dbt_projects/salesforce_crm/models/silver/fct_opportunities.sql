with source as (
    select * from {{ ref('stg_sf_opportunities') }}
),

cleaned as (
    select
        opportunity_id,
        trim(opportunity_name) as opportunity_name,
        account_id,
        owner_id,
        coalesce(amount, 0) as amount,
        trim(stage_name) as stage_name,
        coalesce(nullif(trim(opportunity_type), ''), 'Unknown') as opportunity_type,
        coalesce(probability, 0) as probability,
        coalesce(nullif(trim(forecast_category), ''), 'Unknown') as forecast_category,
        coalesce(nullif(trim(lead_source), ''), 'Unknown') as lead_source,
        close_date,
        is_closed,
        is_won,
        not is_closed as is_open,
        datediff(day, created_at, close_date) as days_to_close,
        date_trunc('month', close_date) as close_month,
        date_trunc('quarter', close_date) as close_quarter,
        extract(year from close_date) as close_year,
        created_at,
        updated_at
    from source
)

select
    {{ dbt_utils.generate_surrogate_key(['opportunity_id']) }} as opportunity_key,
    opportunity_id,
    opportunity_name,
    account_id,
    owner_id,
    amount,
    stage_name,
    opportunity_type,
    probability,
    forecast_category,
    lead_source,
    close_date,
    is_closed,
    is_won,
    is_open,
    days_to_close,
    close_month,
    close_quarter,
    close_year,
    created_at,
    updated_at
from cleaned
