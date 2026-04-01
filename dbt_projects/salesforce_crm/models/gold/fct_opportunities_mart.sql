{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with opportunities as (
    select * from {{ ref('fct_opportunities') }}
),

accounts as (
    select * from {{ ref('dim_accounts') }}
),

final as (
    select
        o.opportunity_id,
        o.opportunity_name,
        o.account_id,
        a.account_name,
        a.industry as account_industry,
        o.owner_id,
        o.amount as deal_amount_usd,
        o.stage_name,
        o.opportunity_type as deal_type,
        o.probability as win_probability_pct,
        o.forecast_category,
        o.lead_source,
        o.close_date,
        o.close_month,
        o.close_quarter,
        o.close_year,
        o.is_closed,
        o.is_won,
        o.is_open,
        o.days_to_close,
        case
            when o.is_won then 'Won'
            when o.is_closed and not o.is_won then 'Lost'
            else 'Open'
        end as opportunity_status,
        o.created_at as opportunity_created_date,
        o.updated_at as opportunity_last_modified_date
    from opportunities o
    left join accounts a on o.account_id = a.account_id
)

select * from final
