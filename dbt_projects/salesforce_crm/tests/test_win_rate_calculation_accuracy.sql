with manual_calc as (
    select
        account_id,
        case
            when count(case when is_closed then 1 end) > 0
            then count(case when is_won then 1 end)::decimal / count(case when is_closed then 1 end)::decimal
            else null
        end as calculated_win_rate
    from {{ ref('fct_opportunities') }}
    where account_id is not null
    group by account_id
),
summary_win_rate as (
    select
        account_id,
        win_rate
    from {{ ref('int_account_opportunity_summary') }}
)
select
    m.account_id,
    m.calculated_win_rate,
    s.win_rate
from manual_calc m
inner join summary_win_rate s
    on m.account_id = s.account_id
where abs(coalesce(m.calculated_win_rate, 0) - coalesce(s.win_rate, 0)) > 0.001
