{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with opportunities as (
    select * from {{ ref('fct_opportunities') }}
),

accounts as (
    select * from {{ ref('dim_accounts') }}
),

revenue as (
    select
        o.account_id,
        a.account_name,
        a.industry,
        a.billing_country,
        count(*) as total_deal_count,
        sum(case when o.is_won then 1 else 0 end) as won_deal_count,
        sum(case when o.is_open then 1 else 0 end) as open_deal_count,
        sum(o.amount) as total_value_usd,
        sum(case when o.is_won then o.amount else 0 end) as won_revenue_usd,
        sum(case when o.is_open then o.amount else 0 end) as pipeline_value_usd,
        avg(case when o.is_won then o.amount end) as avg_won_deal_size_usd,
        avg(case when o.is_closed then o.days_to_close end) as avg_days_to_close
    from opportunities o
    inner join accounts a on o.account_id = a.account_id
    group by o.account_id, a.account_name, a.industry, a.billing_country
)

select * from revenue
