with source as (
    select * from {{ ref('stg_sf_accounts') }}
),

cleaned as (
    select
        account_id,
        trim(account_name) as account_name,
        coalesce(nullif(trim(industry), ''), 'Unknown') as industry,
        coalesce(nullif(trim(account_type), ''), 'Unknown') as account_type,
        owner_id,
        upper(trim(billing_country)) as billing_country,
        trim(billing_city) as billing_city,
        nullif(trim(website), '') as website,
        nullif(trim(phone), '') as phone,
        annual_revenue,
        number_of_employees,
        created_at,
        updated_at
    from source
)

select
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key,
    account_id,
    account_name,
    industry,
    account_type,
    owner_id,
    billing_country,
    billing_city,
    website,
    phone,
    annual_revenue,
    number_of_employees,
    created_at,
    updated_at
from cleaned
