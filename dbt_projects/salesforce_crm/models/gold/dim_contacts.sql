{{
    config(
        materialized='table',
        tags=['gold', 'mart']
    )
}}

with contacts as (
    select * from {{ ref('int_contacts') }}
),

accounts as (
    select
        account_id,
        account_name,
        industry,
        billing_country
    from {{ ref('int_accounts') }}
),

final as (
    select
        contacts.contact_id,
        contacts.account_id,
        accounts.account_name,
        accounts.industry as account_industry,
        accounts.billing_country as account_country,
        contacts.first_name,
        contacts.last_name,
        contacts.full_name as contact_full_name,
        contacts.email as email_address,
        contacts.phone as phone_number,
        contacts.title as job_title,
        contacts.department,
        contacts.lead_source as original_lead_source,
        contacts.mailing_city,
        contacts.mailing_country,
        contacts.owner_id as salesforce_owner_id,
        contacts.created_at as contact_created_date,
        contacts.updated_at as contact_last_modified_date,
        contacts.contact_key,
        contacts.account_key
    from contacts
    left join accounts on contacts.account_id = accounts.account_id
)

select * from final
