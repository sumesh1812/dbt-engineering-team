{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with opportunities as (
    select * from {{ ref('int_opportunities') }}
),

accounts as (
    select
        account_id,
        industry
    from {{ ref('int_accounts') }}
),

final as (
    select
        opportunities.close_month as revenue_month,
        opportunities.close_year as revenue_year,
        coalesce(accounts.industry, 'Unknown') as industry,
        count(distinct opportunities.opportunity_id) as total_closed_deals,
        count(distinct case when opportunities.is_won then opportunities.opportunity_id end) as won_deals,
        count(distinct case when opportunities.is_lost then opportunities.opportunity_id end) as lost_deals,
        sum(case when opportunities.is_won then opportunities.amount else 0 end) as revenue_usd,
        sum(case when opportunities.is_lost then opportunities.amount else 0 end) as lost_revenue_usd,
        case
            when count(case when opportunities.is_won then 1 end) + count(case when opportunities.is_lost then 1 end) > 0
            then (count(case when opportunities.is_won then 1 end)::float / 
                  (count(case when opportunities.is_won then 1 end) + count(case when opportunities.is_lost then 1 end))) * 100
            else null
        end as win_rate_percent
    from opportunities
    left join accounts on opportunities.account_id = accounts.account_id
    where opportunities.close_month is not null
    group by opportunities.close_month, opportunities.close_year, accounts.industry
)

select * from final
