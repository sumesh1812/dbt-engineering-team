with direct_agg as (
    select
        account_id,
        count(*) as opp_count,
        sum(case when is_won then 1 else 0 end) as won_count
    from {{ ref('int_opportunities') }}
    where account_id is not null
    group by account_id
),
summary_table as (
    select
        account_id,
        total_opportunities,
        won_opportunities
    from {{ ref('int_account_opportunity_summary') }}
)
select
    direct_agg.account_id,
    direct_agg.opp_count,
    summary_table.total_opportunities
from direct_agg
inner join summary_table
    on direct_agg.account_id = summary_table.account_id
where direct_agg.opp_count != summary_table.total_opportunities
    or direct_agg.won_count != summary_table.won_opportunities
