with opportunities as (
    select * from {{ ref('slv_opportunities') }}
),

account_metrics as (
    select
        account_id,
        count(*) as total_opportunities,
        sum(case when is_open then 1 else 0 end) as open_opportunities,
        sum(case when is_closed and is_won then 1 else 0 end) as closed_won_opportunities,
        sum(case when is_closed and not is_won then 1 else 0 end) as closed_lost_opportunities,
        sum(case when is_open then amount else 0 end) as total_pipeline_value,
        sum(case when is_won then amount else 0 end) as total_closed_won_value,
        sum(case when is_closed and not is_won then amount else 0 end) as total_closed_lost_value,
        case 
            when sum(case when is_closed then 1 else 0 end) > 0
            then 100.0 * sum(case when is_closed and is_won then 1 else 0 end) / sum(case when is_closed then 1 else 0 end)
            else null
        end as account_win_rate,
        case
            when sum(case when is_won then 1 else 0 end) > 0
            then avg(case when is_won then amount else null end)
            else null
        end as avg_deal_size,
        min(created_at) as first_opportunity_date,
        max(created_at) as last_opportunity_date
    from opportunities
    where account_id is not null
    group by account_id
)

select * from account_metrics
