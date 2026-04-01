select
    account_id,
    trim(account_name) as account_name,
    coalesce(annual_revenue, 0) as annual_revenue,
    coalesce(number_of_employees, 0) as number_of_employees,
    upper(trim(industry)) as industry,
    trim(account_type) as account_type,
    trim(billing_city) as billing_city,
    trim(billing_country) as billing_country,
    owner_id,
    lower(trim(website)) as website,
    phone,
    created_at,
    updated_at,
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key
from {{ ref('stg_sf__accounts') }}
