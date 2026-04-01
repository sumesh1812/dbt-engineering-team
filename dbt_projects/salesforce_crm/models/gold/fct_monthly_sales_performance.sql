{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with opportunities as (
    select * from {{ ref('fct_opportunities') }}
),

monthly as (
    select
        close_month as performance_month,
        close_year as performance_year,
        count(*) as total_opportunities,
        count(case when is_closed then 1 end) as closed_opportunities,
        count(case when is_won then 1 end) as won_opportunities,
        count(case when is_open then 1 end) as open_opportunities,
        sum(amount) as total_value_usd,
        sum(case when is_won then amount else 0 end) as won_revenue_usd,
        sum(case when is_open then amount else 0 end) as pipeline_value_usd,
        avg(case when is_won then amount end) as avg_won_deal_size_usd,
        avg(probability) as avg_win_probability_pct
    from opportunities
    group by close_month, close_year
)

select * from monthly
