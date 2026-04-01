with silver_summary as (
    select
        account_id,
        total_won_value,
        total_pipeline_value
    from {{ ref('int_account_opportunity_summary') }}
),
gold_mart as (
    select
        account_id,
        won_revenue_usd,
        pipeline_value_usd
    from {{ ref('dim_accounts_mart') }}
)
select
    s.account_id,
    s.total_won_value as silver_won,
    g.won_revenue_usd as gold_won,
    s.total_pipeline_value as silver_pipeline,
    g.pipeline_value_usd as gold_pipeline
from silver_summary s
inner join gold_mart g
    on s.account_id = g.account_id
where abs(s.total_won_value - g.won_revenue_usd) > 0.01
    or abs(s.total_pipeline_value - g.pipeline_value_usd) > 0.01
