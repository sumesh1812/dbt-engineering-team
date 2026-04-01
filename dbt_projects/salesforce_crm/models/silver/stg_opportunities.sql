with source as (
    select * from {{ ref('brz_sf_opportunities') }}
),

deduplicated as (
    select *,
        row_number() over (partition by opportunity_id order by modified_at desc) as rn
    from source
),

cleaned as (
    select
        opportunity_id,
        account_id,
        opportunity_name,
        coalesce(amount, 0) as amount,
        stage_name,
        coalesce(probability, 0) as probability,
        coalesce(forecast_category, 'Omitted') as forecast_category,
        coalesce(opportunity_type, 'Unknown') as opportunity_type,
        coalesce(lead_source, 'Unknown') as lead_source,
        close_date,
        date_trunc('month', close_date) as close_month,
        date_trunc('quarter', close_date) as close_quarter,
        year(close_date) as close_year,
        is_closed,
        is_won,
        case when is_closed and not is_won then true else false end as is_lost,
        case when not is_closed then true else false end as is_open,
        case
            when is_closed then datediff(day, created_at, close_date)
            else null
        end as days_to_close,
        owner_id,
        created_at,
        modified_at,
        {{ dbt_utils.generate_surrogate_key(['opportunity_id']) }} as opportunity_key
    from deduplicated
    where rn = 1
)

select * from cleaned
