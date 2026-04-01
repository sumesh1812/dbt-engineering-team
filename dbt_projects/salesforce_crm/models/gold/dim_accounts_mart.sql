{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with accounts as (
    select * from {{ ref('dim_accounts') }}
),

opportunity_summary as (
    select * from {{ ref('int_account_opportunity_summary') }}
),

contact_summary as (
    select * from {{ ref('int_account_contact_summary') }}
),

final as (
    select
        a.account_id,
        a.account_name,
        a.industry,
        a.account_type,
        a.owner_id,
        a.billing_country,
        a.billing_city,
        a.website,
        a.phone,
        a.annual_revenue as annual_revenue_usd,
        a.number_of_employees as employee_count,
        coalesce(c.contact_count, 0) as total_contacts,
        coalesce(o.total_opportunities, 0) as total_opportunities,
        coalesce(o.open_opportunities, 0) as open_opportunities,
        coalesce(o.total_pipeline_value, 0) as pipeline_value_usd,
        coalesce(o.total_won_value, 0) as won_revenue_usd,
        coalesce(o.win_rate, 0) as win_rate_pct,
        a.created_at as account_created_date,
        a.updated_at as account_last_modified_date
    from accounts a
    left join opportunity_summary o on a.account_id = o.account_id
    left join contact_summary c on a.account_id = c.account_id
)

select * from final
