{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with opportunities as (
    select * from {{ ref('stg_opportunities') }}
),

accounts as (
    select
        account_id,
        account_name,
        industry,
        account_type,
        revenue_band
    from {{ ref('stg_accounts') }}
),

monthly_revenue as (
    select
        o.close_month as revenue_month,
        o.close_quarter as revenue_quarter,
        o.close_year as revenue_year,
        a.industry,
        a.account_type,
        a.revenue_band as account_revenue_band,
        o.opportunity_type,
        o.lead_source,
        count(distinct o.opportunity_id) as won_deal_count,
        sum(o.amount) as total_revenue_usd,
        avg(o.amount) as average_deal_size_usd,
        min(o.amount) as smallest_deal_usd,
        max(o.amount) as largest_deal_usd,
        avg(o.days_to_close) as avg_days_to_close
    from opportunities o
    left join accounts a on o.account_id = a.account_id
    where o.is_won = true
    group by
        o.close_month,
        o.close_quarter,
        o.close_year,
        a.industry,
        a.account_type,
        a.revenue_band,
        o.opportunity_type,
        o.lead_source
)

select * from monthly_revenue
