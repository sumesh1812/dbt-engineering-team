with actual_won as (
    select
        account_id,
        sum(amount) as calc_won
    from {{ ref('slv_opportunities') }}
    where is_won = true
      and account_id is not null
    group by account_id
)
select
    s.account_id,
    s.total_closed_won_value,
    a.calc_won
from {{ ref('int_account_opportunity_summary') }} s
inner join actual_won a
    on s.account_id = a.account_id
where abs(s.total_closed_won_value - a.calc_won) > 0.01
