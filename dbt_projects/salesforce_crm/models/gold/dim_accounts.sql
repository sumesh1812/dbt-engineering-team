{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with accounts as (
    select * from {{ ref('slv_accounts') }}
),

opportunity_summary as (
    select * from {{ ref('int_account_opportunity_summary') }}
),

contacts_agg as (
    select
        account_id,
        count(*) as total_contacts
    from {{ ref('slv_contacts') }}
    where account_id is not null
    group by account_id
),

final as (
    select
        a.account_id,
        a.account_name,
        a.industry,
        a.account_type,
        a.billing_country,
        a.billing_city,
        a.phone as account_phone,
        a.website,
        a.owner_id as account_owner_id,
        a.number_of_employees as employee_count,
        a.annual_revenue as annual_revenue_usd,
        coalesce(c.total_contacts, 0) as total_contacts,
        coalesce(o.total_opportunities, 0) as total_opportunities,
        coalesce(o.open_opportunities, 0) as open_opportunities,
        coalesce(o.closed_won_opportunities, 0) as closed_won_count,
        coalesce(o.closed_lost_opportunities, 0) as closed_lost_count,
        coalesce(o.total_pipeline_value, 0) as pipeline_value_usd,
        coalesce(o.total_closed_won_value, 0) as closed_won_value_usd,
        coalesce(o.total_closed_lost_value, 0) as closed_lost_value_usd,
        o.account_win_rate as win_rate_percent,
        o.avg_deal_size as avg_deal_size_usd,
        o.first_opportunity_date,
        o.last_opportunity_date,
        a.created_at as account_created_at,
        a.updated_at as account_updated_at
    from accounts a
    left join opportunity_summary o on a.account_id = o.account_id
    left join contacts_agg c on a.account_id = c.account_id
)

select * from final
