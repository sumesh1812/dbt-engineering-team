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
        account_type,
        industry
    from {{ ref('stg_accounts') }}
),

final as (
    select
        o.opportunity_id,
        o.account_id as parent_account_id,
        a.account_name as parent_account_name,
        a.account_type as parent_account_type,
        a.industry as parent_industry,
        o.opportunity_name as opportunity_name,
        o.amount as opportunity_value_usd,
        o.stage_name as current_stage,
        o.probability as win_probability_pct,
        o.forecast_category as forecast_bucket,
        o.opportunity_type as opportunity_type,
        o.lead_source as original_lead_source,
        o.close_date as expected_close_date,
        o.close_month as close_month,
        o.close_quarter as close_quarter,
        o.close_year as close_year,
        o.is_closed as is_opportunity_closed,
        o.is_won as is_opportunity_won,
        o.is_lost as is_opportunity_lost,
        o.is_open as is_opportunity_open,
        o.days_to_close as actual_days_to_close,
        o.owner_id as opportunity_owner_id,
        o.created_at as opportunity_created_at,
        o.modified_at as opportunity_modified_at
    from opportunities o
    left join accounts a on o.account_id = a.account_id
)

select * from final
