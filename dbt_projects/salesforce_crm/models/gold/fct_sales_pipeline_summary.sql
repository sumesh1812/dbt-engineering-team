{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with opportunities as (
    select * from {{ ref('fct_opportunities') }}
),

summary as (
    select
        stage_name,
        close_quarter,
        opportunity_type as deal_type,
        count(*) as opportunity_count,
        sum(amount) as total_pipeline_value_usd,
        avg(amount) as avg_deal_size_usd,
        sum(case when is_open then amount else 0 end) as open_pipeline_usd,
        sum(case when is_won then amount else 0 end) as won_revenue_usd,
        sum(case when is_closed and not is_won then amount else 0 end) as lost_value_usd,
        count(case when is_open then 1 end) as open_count,
        count(case when is_won then 1 end) as won_count,
        count(case when is_closed and not is_won then 1 end) as lost_count
    from opportunities
    group by stage_name, close_quarter, opportunity_type
)

select * from summary
