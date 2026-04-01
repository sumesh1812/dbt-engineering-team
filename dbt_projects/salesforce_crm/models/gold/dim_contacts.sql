{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with contacts as (
    select * from {{ ref('slv_contacts') }}
),

accounts as (
    select
        account_id,
        account_name,
        industry,
        billing_country
    from {{ ref('slv_accounts') }}
),

final as (
    select
        c.contact_id,
        c.account_id,
        a.account_name,
        a.industry as account_industry,
        a.billing_country as account_country,
        c.first_name,
        c.last_name,
        c.full_name as contact_full_name,
        c.email as contact_email,
        c.phone as contact_phone,
        c.title as job_title,
        c.department,
        c.mailing_city,
        c.mailing_country,
        c.owner_id as contact_owner_id,
        c.lead_source,
        c.created_at as contact_created_at,
        c.updated_at as contact_updated_at
    from contacts c
    left join accounts a on c.account_id = a.account_id
)

select * from final
