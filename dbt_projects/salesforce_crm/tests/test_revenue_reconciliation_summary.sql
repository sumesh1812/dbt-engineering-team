with opportunity_total as (
    select sum(amount) as opp_total
    from {{ ref('slv_opportunities') }}
    where is_won = true
),
summary_total as (
    select sum(total_closed_won_value) as sum_total
    from {{ ref('int_account_opportunity_summary') }}
)
select
    opp_total,
    sum_total,
    abs(opp_total - sum_total) as revenue_diff
from opportunity_total
cross join summary_total
where abs(opp_total - sum_total) > 0.01
