with opportunity_calcs as (
    select
        account_id,
        sum(case when is_won then amount else 0 end) as calc_won_revenue,
        sum(case when is_open then amount else 0 end) as calc_pipeline
    from {{ ref('fct_opportunities') }}
    group by account_id
),
gold_revenue as (
    select
        account_id,
        won_revenue_usd,
        pipeline_value_usd
    from {{ ref('fct_revenue_by_account') }}
)
select
    o.account_id,
    o.calc_won_revenue,
    g.won_revenue_usd,
    o.calc_pipeline,
    g.pipeline_value_usd
from opportunity_calcs o
inner join gold_revenue g
    on o.account_id = g.account_id
where abs(o.calc_won_revenue - g.won_revenue_usd) > 0.01
    or abs(o.calc_pipeline - g.pipeline_value_usd) > 0.01
