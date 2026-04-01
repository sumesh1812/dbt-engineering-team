with silver_agg as (
    select
        sum(total_won_value) as total_won
    from {{ ref('int_account_opportunity_summary') }}
),
gold_agg as (
    select
        sum(lifetime_revenue_usd) as total_won
    from {{ ref('dim_accounts') }}
)
select
    silver_agg.total_won as silver_total,
    gold_agg.total_won as gold_total
from silver_agg
cross join gold_agg
where abs(silver_agg.total_won - gold_agg.total_won) > 0.01
