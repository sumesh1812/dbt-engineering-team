with opp_revenue_by_account as (
    select
        account_id,
        sum(case when is_won then amount else 0 end) as opp_won_revenue
    from {{ ref('stg_opportunities') }}
    where account_id is not null
    group by account_id
),
summary_revenue as (
    select
        account_id,
        total_won_revenue
    from {{ ref('int_account_opportunity_summary') }}
)
select
    o.account_id,
    o.opp_won_revenue,
    s.total_won_revenue,
    abs(o.opp_won_revenue - s.total_won_revenue) as diff
from opp_revenue_by_account o
left join summary_revenue s
    on o.account_id = s.account_id
where abs(o.opp_won_revenue - coalesce(s.total_won_revenue, 0)) > 0.01
