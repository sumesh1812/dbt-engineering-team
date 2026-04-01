with actual_pipeline as (
    select
        account_id,
        sum(amount) as calc_pipeline
    from {{ ref('slv_opportunities') }}
    where is_open = true
      and account_id is not null
    group by account_id
)
select
    s.account_id,
    s.total_pipeline_value,
    a.calc_pipeline
from {{ ref('int_account_opportunity_summary') }} s
inner join actual_pipeline a
    on s.account_id = a.account_id
where abs(s.total_pipeline_value - a.calc_pipeline) > 0.01
