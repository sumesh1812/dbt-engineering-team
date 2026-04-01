{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with opportunities as (
    select * from {{ ref('slv_opportunities') }}
),

accounts as (
    select
        account_id,
        industry,
        account_type,
        billing_country
    from {{ ref('slv_accounts') }}
),

monthly_revenue as (
    select
        o.close_month,
        a.industry,
        a.account_type,
        a.billing_country,
        o.opportunity_type,
        o.lead_source,
        count(distinct o.opportunity_id) as opportunities_closed,
        count(distinct case when o.is_won then o.opportunity_id end) as opportunities_won,
        sum(case when o.is_won then o.amount else 0 end) as revenue_usd,
        avg(case when o.is_won then o.amount end) as avg_deal_size_usd,
        case
            when count(distinct case when o.is_closed then o.opportunity_id end) > 0
            then 100.0 * count(distinct case when o.is_won then o.opportunity_id end) / 
                 count(distinct case when o.is_closed then o.opportunity_id end)
            else null
        end as win_rate_percent,
        avg(case when o.is_won then o.days_to_close end) as avg_days_to_close
    from opportunities o
    left join accounts a on o.account_id = a.account_id
    where o.close_month is not null
    group by
        o.close_month,
        a.industry,
        a.account_type,
        a.billing_country,
        o.opportunity_type,
        o.lead_source
)

select * from monthly_revenue
