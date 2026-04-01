with opp_counts as (
    select
        account_id,
        count(*) as actual_opp_count
    from {{ ref('stg_opportunities') }}
    where account_id is not null
    group by account_id
),
summary_counts as (
    select
        account_id,
        total_opportunities
    from {{ ref('int_account_opportunity_summary') }}
)
select
    o.account_id,
    o.actual_opp_count,
    s.total_opportunities
from opp_counts o
left join summary_counts s
    on o.account_id = s.account_id
where o.actual_opp_count != coalesce(s.total_opportunities, 0)
