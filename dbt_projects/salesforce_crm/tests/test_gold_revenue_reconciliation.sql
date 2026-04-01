with silver_revenue as (
    select sum(amount) as total_silver_revenue
    from {{ ref('stg_opportunities') }}
    where is_won = true
),
gold_revenue as (
    select sum(opportunity_value_usd) as total_gold_revenue
    from {{ ref('fct_opportunities') }}
    where is_opportunity_won = true
)
select
    s.total_silver_revenue,
    g.total_gold_revenue,
    abs(s.total_silver_revenue - g.total_gold_revenue) as diff
from silver_revenue s
cross join gold_revenue g
where abs(s.total_silver_revenue - g.total_gold_revenue) > 0.01
