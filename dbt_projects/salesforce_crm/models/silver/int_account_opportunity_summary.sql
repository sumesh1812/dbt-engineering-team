with opportunities as (
    select * from {{ ref('fct_opportunities') }}
),

summary as (
    select
        account_id,
        count(*) as total_opportunities,
        count(case when is_open then 1 end) as open_opportunities,
        count(case when is_won then 1 end) as closed_won_opportunities,
        count(case when is_closed and not is_won then 1 end) as closed_lost_opportunities,
        sum(case when is_open then amount else 0 end) as total_pipeline_value,
        sum(case when is_won then amount else 0 end) as total_won_value,
        sum(case when is_closed and not is_won then amount else 0 end) as total_lost_value,
        avg(amount) as avg_deal_size,
        case
            when count(case when is_closed then 1 end) > 0
            then count(case when is_won then 1 end)::decimal / count(case when is_closed then 1 end)::decimal
            else null
        end as win_rate
    from opportunities
    where account_id is not null
    group by account_id
)

select
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_opportunity_key,
    account_id,
    total_opportunities,
    open_opportunities,
    closed_won_opportunities,
    closed_lost_opportunities,
    total_pipeline_value,
    total_won_value,
    total_lost_value,
    avg_deal_size,
    win_rate
from summary
