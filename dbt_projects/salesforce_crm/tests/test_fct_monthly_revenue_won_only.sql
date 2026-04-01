with monthly_counts as (
    select
        close_month,
        count(*) as opp_count
    from {{ ref('stg_opportunities') }}
    where is_won = true
    group by close_month
),
fact_counts as (
    select
        revenue_month,
        sum(won_deal_count) as fact_count
    from {{ ref('fct_monthly_revenue') }}
    group by revenue_month
)
select
    m.close_month,
    m.opp_count,
    f.fact_count
from monthly_counts m
left join fact_counts f
    on m.close_month = f.revenue_month
where m.opp_count != coalesce(f.fact_count, 0)
