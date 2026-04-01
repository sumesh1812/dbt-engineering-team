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
        industry
    from {{ ref('int_accounts') }}
),

final as (
    select
        current_date as snapshot_date,
        opportunities.opportunity_id,
        opportunities.account_id,
        accounts.account_name,
        accounts.industry,
        opportunities.opportunity_name,
        opportunities.stage_name as current_stage,
        opportunities.amount as opportunity_value_usd,
        opportunities.weighted_amount as weighted_value_usd,
        opportunities.probability as win_probability_percent,
        opportunities.forecast_category,
        opportunities.close_date as expected_close_date,
        datediff(day, current_date, opportunities.close_date) as days_until_close,
        opportunities.owner_id as salesforce_owner_id,
        opportunities.created_at as opportunity_created_date
    from opportunities
    left join accounts on opportunities.account_id = accounts.account_id
    where opportunities.is_open = true
)

select * from final
