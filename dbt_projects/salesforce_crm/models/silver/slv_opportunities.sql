with source as (
    select * from {{ ref('brz_sf_opportunities') }}
),

cleaned as (
    select
        opportunity_id,
        trim(opportunity_name) as opportunity_name,
        account_id,
        owner_id,
        upper(trim(coalesce(opportunity_type, 'Unknown'))) as opportunity_type,
        trim(coalesce(stage_name, 'Unknown')) as stage_name,
        upper(trim(coalesce(forecast_category, 'Unknown'))) as forecast_category,
        coalesce(amount, 0) as amount,
        least(greatest(coalesce(probability, 0), 0), 100) as probability,
        close_date,
        is_closed,
        is_won,
        not is_closed as is_open,
        upper(trim(coalesce(lead_source, 'Unknown'))) as lead_source,
        created_at,
        updated_at,
        case 
            when is_closed and close_date is not null 
            then datediff(day, created_at, close_date)
            else null
        end as days_to_close,
        date_trunc('month', close_date) as close_month,
        date_trunc('quarter', close_date) as close_quarter,
        current_timestamp() as _slv_loaded_at
    from source
)

select * from cleaned
