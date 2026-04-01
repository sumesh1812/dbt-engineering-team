{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with accounts as (
    select * from {{ ref('stg_accounts') }}
),

account_summary as (
    select * from {{ ref('int_account_opportunity_summary') }}
),

final as (
    select
        a.account_id,
        a.account_name as account_name,
        a.account_type as account_type,
        a.industry as industry_name,
        a.annual_revenue as annual_revenue_usd,
        a.number_of_employees as employee_count,
        a.employee_band as employee_size_band,
        a.revenue_band as revenue_size_band,
        a.phone as phone_number,
        a.website as website_url,
        a.billing_city as city,
        a.billing_country as country,
        a.owner_id as account_owner_id,
        a.created_at as account_created_at,
        a.modified_at as account_modified_at,
        coalesce(acs.total_opportunities, 0) as lifetime_opportunity_count,
        coalesce(acs.open_opportunities, 0) as current_open_opportunities,
        coalesce(acs.closed_won_opportunities, 0) as lifetime_won_count,
        coalesce(acs.closed_lost_opportunities, 0) as lifetime_lost_count,
        coalesce(acs.total_pipeline_value, 0) as current_pipeline_value_usd,
        coalesce(acs.total_won_revenue, 0) as lifetime_won_revenue_usd,
        coalesce(acs.total_lost_value, 0) as lifetime_lost_value_usd,
        acs.avg_deal_size as average_deal_size_usd,
        acs.last_won_date as most_recent_win_date,
        acs.earliest_open_close_date as next_expected_close_date,
        acs.avg_days_to_close as average_days_to_close,
        case
            when coalesce(acs.total_won_revenue, 0) > 0 then 'Customer'
            when coalesce(acs.open_opportunities, 0) > 0 then 'Prospect'
            else 'Inactive'
        end as customer_status
    from accounts a
    left join account_summary acs on a.account_id = acs.account_id
)

select * from final
