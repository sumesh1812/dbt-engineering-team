{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with opportunities as (
    select * from {{ ref('slv_opportunities') }}
),

accounts as (
    select
        account_id,
        account_name,
        industry,
        account_type,
        billing_country
    from {{ ref('slv_accounts') }}
),

final as (
    select
        o.opportunity_id,
        o.opportunity_name,
        o.account_id,
        a.account_name,
        a.industry as account_industry,
        a.account_type,
        a.billing_country as account_country,
        o.owner_id as opportunity_owner_id,
        o.opportunity_type,
        o.stage_name,
        o.forecast_category,
        o.amount as opportunity_amount_usd,
        o.probability as win_probability_percent,
        o.close_date,
        o.is_closed,
        o.is_won,
        o.is_open,
        o.lead_source,
        o.days_to_close,
        o.close_month,
        o.close_quarter,
        o.created_at as opportunity_created_at,
        o.updated_at as opportunity_updated_at
    from opportunities o
    left join accounts a on o.account_id = a.account_id
)

select * from final
