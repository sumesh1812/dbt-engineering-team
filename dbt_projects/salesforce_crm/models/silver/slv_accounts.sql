with source as (
    select * from {{ ref('brz_sf_accounts') }}
),

cleaned as (
    select
        account_id,
        coalesce(account_name, 'Unknown') as account_name,
        upper(trim(coalesce(industry, 'Unknown'))) as industry,
        upper(trim(coalesce(account_type, 'Unknown'))) as account_type,
        upper(trim(billing_country)) as billing_country,
        trim(billing_city) as billing_city,
        trim(phone) as phone,
        lower(trim(website)) as website,
        owner_id,
        coalesce(number_of_employees, 0) as number_of_employees,
        coalesce(annual_revenue, 0) as annual_revenue,
        created_at,
        updated_at,
        current_timestamp() as _slv_loaded_at
    from source
)

select * from cleaned
