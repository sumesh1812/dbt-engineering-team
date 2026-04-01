with accounts as (
    select * from {{ ref('stg_accounts') }}
),

opportunities as (
    select * from {{ ref('stg_opportunities') }}
),

account_metrics as (
    select
        account_id,
        count(*) as total_opportunities,
        sum(case when is_open then 1 else 0 end) as open_opportunities,
        sum(case when is_won then 1 else 0 end) as closed_won_opportunities,
        sum(case when is_lost then 1 else 0 end) as closed_lost_opportunities,
        sum(case when is_open then amount else 0 end) as total_pipeline_value,
        sum(case when is_won then amount else 0 end) as total_won_revenue,
        sum(case when is_lost then amount else 0 end) as total_lost_value,
        avg(case when is_closed then amount else null end) as avg_deal_size,
        max(case when is_won then close_date else null end) as last_won_date,
        min(case when is_open then close_date else null end) as earliest_open_close_date,
        avg(case when is_closed then days_to_close else null end) as avg_days_to_close,
        {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_opportunity_summary_key
    from opportunities
    where account_id is not null
    group by account_id
)

select
    a.account_id,
    a.account_name,
    a.account_type,
    a.industry,
    coalesce(am.total_opportunities, 0) as total_opportunities,
    coalesce(am.open_opportunities, 0) as open_opportunities,
    coalesce(am.closed_won_opportunities, 0) as closed_won_opportunities,
    coalesce(am.closed_lost_opportunities, 0) as closed_lost_opportunities,
    coalesce(am.total_pipeline_value, 0) as total_pipeline_value,
    coalesce(am.total_won_revenue, 0) as total_won_revenue,
    coalesce(am.total_lost_value, 0) as total_lost_value,
    am.avg_deal_size,
    am.last_won_date,
    am.earliest_open_close_date,
    am.avg_days_to_close,
    am.account_opportunity_summary_key
from accounts a
left join account_metrics am on a.account_id = am.account_id
