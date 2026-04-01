{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with base_accounts as (
    select * from {{ ref('int_accounts') }}
),

opp_summary as (
    select * from {{ ref('int_account_opportunity_summary') }}
),

contact_summary as (
    select * from {{ ref('int_account_contact_summary') }}
),

final as (
    select
        base_accounts.account_id,
        base_accounts.account_name,
        base_accounts.annual_revenue as annual_revenue_usd,
        base_accounts.number_of_employees as employee_count,
        base_accounts.industry,
        base_accounts.account_type,
        base_accounts.billing_city,
        base_accounts.billing_country,
        base_accounts.website,
        base_accounts.phone as phone_number,
        base_accounts.owner_id as salesforce_owner_id,
        coalesce(opp_summary.total_opportunities, 0) as total_opportunities,
        coalesce(opp_summary.open_opportunities, 0) as open_opportunity_count,
        coalesce(opp_summary.won_opportunities, 0) as won_opportunity_count,
        coalesce(opp_summary.lost_opportunities, 0) as lost_opportunity_count,
        coalesce(opp_summary.total_pipeline_value, 0) as open_pipeline_value_usd,
        coalesce(opp_summary.total_won_value, 0) as lifetime_revenue_usd,
        coalesce(opp_summary.total_lost_value, 0) as lost_revenue_usd,
        opp_summary.win_rate as win_rate_percent,
        coalesce(contact_summary.total_contacts, 0) as total_contacts,
        base_accounts.created_at as account_created_date,
        base_accounts.updated_at as account_last_modified_date,
        base_accounts.account_key
    from base_accounts
    left join opp_summary on base_accounts.account_id = opp_summary.account_id
    left join contact_summary on base_accounts.account_id = contact_summary.account_id
)

select * from final
