{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with opportunities as (
    select * from {{ ref('int_opportunities') }}
),

calendar as (
    select distinct close_date as snapshot_date
    from opportunities
    where close_date is not null
),

final as (
    select
        calendar.snapshot_date,
        count(distinct opportunities.opportunity_id) as total_opportunities,
        count(distinct case when opportunities.is_open then opportunities.opportunity_id end) as open_opportunities,
        count(distinct case when opportunities.is_won then opportunities.opportunity_id end) as won_opportunities,
        count(distinct case when opportunities.is_lost then opportunities.opportunity_id end) as lost_opportunities,
        sum(case when opportunities.is_open then opportunities.amount else 0 end) as pipeline_value_usd,
        sum(case when opportunities.is_won then opportunities.amount else 0 end) as won_value_usd,
        sum(case when opportunities.is_lost then opportunities.amount else 0 end) as lost_value_usd,
        sum(case when opportunities.is_open then opportunities.weighted_amount else 0 end) as weighted_pipeline_usd
    from calendar
    left join opportunities on opportunities.close_date = calendar.snapshot_date
    group by calendar.snapshot_date
)

select * from final
