{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with opportunities as (
    select * from {{ ref('slv_opportunities') }}
),

owner_metrics as (
    select
        owner_id,
        count(*) as total_opportunities,
        sum(case when is_open then 1 else 0 end) as open_opportunities,
        sum(case when is_closed then 1 else 0 end) as closed_opportunities,
        sum(case when is_won then 1 else 0 end) as won_opportunities,
        sum(case when is_closed and not is_won then 1 else 0 end) as lost_opportunities,
        sum(case when is_open then amount else 0 end) as pipeline_value_usd,
        sum(case when is_won then amount else 0 end) as total_revenue_usd,
        avg(case when is_won then amount end) as avg_deal_size_usd,
        case
            when sum(case when is_closed then 1 else 0 end) > 0
            then 100.0 * sum(case when is_won then 1 else 0 end) / 
                 sum(case when is_closed then 1 else 0 end)
            else null
        end as win_rate_percent,
        avg(case when is_won then days_to_close end) as avg_days_to_close_won,
        min(created_at) as first_opportunity_date,
        max(updated_at) as last_activity_date
    from opportunities
    where owner_id is not null
    group by owner_id
)

select * from owner_metrics
