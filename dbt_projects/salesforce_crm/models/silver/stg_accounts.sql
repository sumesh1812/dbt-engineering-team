with source as (
    select * from {{ ref('brz_sf_accounts') }}
),

deduplicated as (
    select *,
        row_number() over (partition by account_id order by modified_at desc) as rn
    from source
),

cleaned as (
    select
        account_id,
        account_name,
        coalesce(account_type, 'Unclassified') as account_type,
        coalesce(industry, 'Unknown') as industry,
        coalesce(annual_revenue, 0) as annual_revenue,
        coalesce(number_of_employees, 0) as number_of_employees,
        case
            when coalesce(number_of_employees, 0) < 50 then 'Small'
            when coalesce(number_of_employees, 0) between 50 and 500 then 'Medium'
            when coalesce(number_of_employees, 0) > 500 then 'Large'
            else 'Small'
        end as employee_band,
        case
            when coalesce(annual_revenue, 0) < 1000000 then 'Under 1M'
            when coalesce(annual_revenue, 0) between 1000000 and 10000000 then '1M-10M'
            when coalesce(annual_revenue, 0) between 10000001 and 100000000 then '10M-100M'
            when coalesce(annual_revenue, 0) > 100000000 then 'Over 100M'
            else 'Under 1M'
        end as revenue_band,
        phone,
        website,
        coalesce(billing_city, 'Unknown') as billing_city,
        coalesce(billing_country, 'Unknown') as billing_country,
        owner_id,
        created_at,
        modified_at,
        {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key
    from deduplicated
    where rn = 1
)

select * from cleaned
