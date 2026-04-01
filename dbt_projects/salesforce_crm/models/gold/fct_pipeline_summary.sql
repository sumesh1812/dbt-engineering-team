{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with opportunities as (
    select * from {{ ref('slv_opportunities') }}
),

pipeline_metrics as (
    select
        stage_name,
        forecast_category,
        opportunity_type,
        lead_source,
        count(*) as opportunity_count,
        sum(amount) as total_value_usd,
        avg(amount) as avg_opportunity_value_usd,
        min(amount) as min_opportunity_value_usd,
        max(amount) as max_opportunity_value_usd,
        avg(probability) as avg_win_probability_percent,
        sum(case when is_open then 1 else 0 end) as open_count,
        sum(case when is_closed and is_won then 1 else 0 end) as closed_won_count,
        sum(case when is_closed and not is_won then 1 else 0 end) as closed_lost_count,
        sum(case when is_open then amount else 0 end) as open_pipeline_value_usd,
        sum(case when is_won then amount else 0 end) as closed_won_value_usd
    from opportunities
    group by
        stage_name,
        forecast_category,
        opportunity_type,
        lead_source
)

select * from pipeline_metrics
