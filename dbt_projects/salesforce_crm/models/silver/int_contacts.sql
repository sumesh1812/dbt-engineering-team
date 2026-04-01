select
    contact_id,
    account_id,
    trim(first_name) as first_name,
    trim(last_name) as last_name,
    concat(
        coalesce(trim(first_name) || ' ', ''),
        trim(last_name)
    ) as full_name,
    lower(trim(email)) as email,
    phone,
    trim(title) as title,
    trim(department) as department,
    trim(lead_source) as lead_source,
    trim(mailing_city) as mailing_city,
    trim(mailing_country) as mailing_country,
    owner_id,
    created_at,
    updated_at,
    {{ dbt_utils.generate_surrogate_key(['contact_id']) }} as contact_key,
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key
from {{ ref('stg_sf__contacts') }}
