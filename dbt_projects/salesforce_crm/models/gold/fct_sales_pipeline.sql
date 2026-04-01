{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with opportunities as (
    select * from {{ ref('stg_opportunities') }}
),

accounts as (
    select
        account_id,
        account_name,
        industry,
        revenue_band
    from {{ ref('stg_accounts') }}
),

pipeline as (
    select
        o.opportunity_id,
        o.account_id,
        a.account_name,
        a.industry,
        a.revenue_band,
        o.opportunity_name,
        o.stage_name as pipeline_stage,
        o.forecast_category,
        o.amount as pipeline_value_usd,
        o.probability as win_probability_pct,
        o.close_date as expected_close_date,
        o.close_month,
        o.close_quarter,
        o.close_year,
        o.owner_id as sales_rep_id,
        o.lead_source,
        o.opportunity_type,
        o.created_at as opportunity_created_at,
        datediff(day, o.created_at, current_date()) as days_in_pipeline,
        case
            when o.close_date < current_date() then true
            else false
        end as is_overdue
    from opportunities o
    left join accounts a on o.account_id = a.account_id
    where o.is_open = true
)

select * from pipeline
