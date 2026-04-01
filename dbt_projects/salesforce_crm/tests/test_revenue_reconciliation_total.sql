with opp_won_revenue as (
    select sum(amount) as total_won_revenue
    from {{ ref('stg_opportunities') }}
    where is_won = true
),
account_summary_revenue as (
    select sum(total_won_revenue) as total_summary_revenue
    from {{ ref('int_account_opportunity_summary') }}
)
select
    opp.total_won_revenue,
    acs.total_summary_revenue,
    abs(opp.total_won_revenue - acs.total_summary_revenue) as revenue_diff
from opp_won_revenue opp
cross join account_summary_revenue acs
where abs(opp.total_won_revenue - acs.total_summary_revenue) > 0.01
