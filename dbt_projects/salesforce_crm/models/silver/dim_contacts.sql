with source as (
    select * from {{ ref('stg_sf_contacts') }}
),

cleaned as (
    select
        contact_id,
        account_id,
        owner_id,
        nullif(trim(first_name), '') as first_name,
        trim(last_name) as last_name,
        concat(
            coalesce(nullif(trim(first_name), ''), ''),
            case when nullif(trim(first_name), '') is not null then ' ' else '' end,
            trim(last_name)
        ) as full_name,
        nullif(trim(email), '') as email,
        nullif(trim(phone), '') as phone,
        nullif(trim(title), '') as title,
        nullif(trim(department), '') as department,
        coalesce(nullif(trim(lead_source), ''), 'Unknown') as lead_source,
        nullif(trim(mailing_city), '') as mailing_city,
        upper(trim(mailing_country)) as mailing_country,
        created_at,
        updated_at
    from source
)

select
    {{ dbt_utils.generate_surrogate_key(['contact_id']) }} as contact_key,
    contact_id,
    account_id,
    owner_id,
    first_name,
    last_name,
    full_name,
    email,
    phone,
    title,
    department,
    lead_source,
    mailing_city,
    mailing_country,
    created_at,
    updated_at
from cleaned
