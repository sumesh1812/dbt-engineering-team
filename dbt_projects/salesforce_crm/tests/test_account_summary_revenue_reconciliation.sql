with opportunity_totals as (
    select
        account_id,
        sum(case when is_won then amount else 0 end) as calc_won_value,
        sum(case when is_open then amount else 0 end) as calc_pipeline_value
    from {{ ref('fct_opportunities') }}
    where account_id is not null
    group by account_id
),
summary_totals as (
    select
        account_id,
        total_won_value,
        total_pipeline_value
    from {{ ref('int_account_opportunity_summary') }}
)
select
    o.account_id,
    o.calc_won_value,
    s.total_won_value,
    o.calc_pipeline_value,
    s.total_pipeline_value
from opportunity_totals o
inner join summary_totals s
    on o.account_id = s.account_id
where abs(o.calc_won_value - s.total_won_value) > 0.01
    or abs(o.calc_pipeline_value - s.total_pipeline_value) > 0.01
