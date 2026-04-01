{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with opportunities as (
    select * from {{ ref('int_opportunities') }}
),

accounts as (
    select
        account_id,
        account_name,
        industry,
        account_type
    from {{ ref('int_accounts') }}
),

final as (
    select
        opportunities.opportunity_id,
        opportunities.account_id,
        accounts.account_name,
        accounts.industry as account_industry,
        accounts.account_type,
        opportunities.opportunity_name,
        opportunities.amount as opportunity_value_usd,
        opportunities.weighted_amount as weighted_value_usd,
        opportunities.stage_name as current_stage,
        opportunities.probability as win_probability_percent,
        opportunities.forecast_category,
        opportunities.opportunity_type,
        opportunities.lead_source as original_lead_source,
        opportunities.opportunity_status,
        opportunities.is_closed,
        opportunities.is_won,
        opportunities.is_lost,
        opportunities.is_open,
        opportunities.close_date,
        opportunities.days_to_close as sales_cycle_days,
        opportunities.close_month,
        opportunities.close_quarter,
        opportunities.close_year,
        opportunities.owner_id as salesforce_owner_id,
        opportunities.created_at as opportunity_created_date,
        opportunities.updated_at as opportunity_last_modified_date,
        opportunities.opportunity_key,
        opportunities.account_key
    from opportunities
    left join accounts on opportunities.account_id = accounts.account_id
)

select * from final
