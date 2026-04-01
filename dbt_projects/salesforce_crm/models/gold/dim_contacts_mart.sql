{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with contacts as (
    select * from {{ ref('dim_contacts') }}
),

accounts as (
    select * from {{ ref('dim_accounts') }}
),

final as (
    select
        c.contact_id,
        c.full_name as contact_name,
        c.first_name,
        c.last_name,
        c.email,
        c.phone as contact_phone,
        c.title as job_title,
        c.department,
        c.lead_source,
        c.mailing_city,
        c.mailing_country,
        c.account_id,
        a.account_name,
        a.industry as account_industry,
        a.billing_country as account_country,
        c.owner_id,
        c.created_at as contact_created_date,
        c.updated_at as contact_last_modified_date
    from contacts c
    left join accounts a on c.account_id = a.account_id
)

select * from final
