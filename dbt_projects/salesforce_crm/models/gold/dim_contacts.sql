{{ config(
    materialized='table',
    tags=['gold', 'mart']
) }}

with contacts as (
    select * from {{ ref('stg_contacts') }}
),

accounts as (
    select
        account_id,
        account_name,
        account_type,
        industry
    from {{ ref('stg_accounts') }}
),

final as (
    select
        c.contact_id,
        c.account_id as parent_account_id,
        a.account_name as parent_account_name,
        a.account_type as parent_account_type,
        a.industry as parent_industry,
        c.first_name,
        c.last_name,
        c.full_name as contact_full_name,
        c.email as email_address,
        c.email_domain,
        c.phone as phone_number,
        c.title as job_title,
        c.department as department_name,
        c.lead_source as original_lead_source,
        c.mailing_city as city,
        c.mailing_country as country,
        c.owner_id as contact_owner_id,
        c.created_at as contact_created_at,
        c.modified_at as contact_modified_at,
        case when c.account_id is not null then true else false end as has_parent_account
    from contacts c
    left join accounts a on c.account_id = a.account_id
)

select * from final
