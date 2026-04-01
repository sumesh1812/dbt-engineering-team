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
        account_type
    from {{ ref('stg_accounts') }}
),

sales_performance as (
    select
        o.close_month as performance_month,
        o.close_quarter as performance_quarter,
        o.close_year as performance_year,
        o.owner_id as sales_rep_id,
        a.industry,
        a.account_type,
        o.opportunity_type,
        o.lead_source,
        count(distinct o.opportunity_id) as total_closed_opportunities,
        sum(case when o.is_won then 1 else 0 end) as won_opportunities,
        sum(case when o.is_lost then 1 else 0 end) as lost_opportunities,
        sum(case when o.is_won then o.amount else 0 end) as won_revenue_usd,
        sum(case when o.is_lost then o.amount else 0 end) as lost_revenue_usd,
        avg(case when o.is_won then o.amount else null end) as avg_won_deal_size_usd,
        avg(case when o.is_closed then o.days_to_close else null end) as avg_days_to_close,
        case
            when count(distinct o.opportunity_id) > 0
            then sum(case when o.is_won then 1 else 0 end)::float / count(distinct o.opportunity_id)
            else 0
        end as win_rate_pct
    from opportunities o
    left join accounts a on o.account_id = a.account_id
    where o.is_closed = true
    group by
        o.close_month,
        o.close_quarter,
        o.close_year,
        o.owner_id,
        a.industry,
        a.account_type,
        o.opportunity_type,
        o.lead_source
)

select * from sales_performance
