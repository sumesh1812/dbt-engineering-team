with source as (
    select * from {{ ref('brz_sf_contacts') }}
),

cleaned as (
    select
        contact_id,
        account_id,
        trim(initcap(first_name)) as first_name,
        trim(initcap(coalesce(last_name, 'Unknown'))) as last_name,
        trim(initcap(coalesce(first_name, ''))) || ' ' || trim(initcap(coalesce(last_name, 'Unknown'))) as full_name,
        lower(trim(email)) as email,
        trim(phone) as phone,
        trim(title) as title,
        upper(trim(department)) as department,
        trim(mailing_city) as mailing_city,
        upper(trim(mailing_country)) as mailing_country,
        owner_id,
        upper(trim(coalesce(lead_source, 'Unknown'))) as lead_source,
        created_at,
        updated_at,
        current_timestamp() as _slv_loaded_at
    from source
)

select * from cleaned
