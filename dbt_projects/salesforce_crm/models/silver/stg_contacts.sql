with source as (
    select * from {{ ref('brz_sf_contacts') }}
),

deduplicated as (
    select *,
        row_number() over (partition by contact_id order by modified_at desc) as rn
    from source
),

cleaned as (
    select
        contact_id,
        account_id,
        coalesce(first_name, '') as first_name,
        last_name,
        concat(coalesce(first_name, ''), ' ', last_name) as full_name,
        email,
        case
            when email is not null and contains(email, '@') then split_part(email, '@', 2)
            else null
        end as email_domain,
        phone,
        coalesce(title, 'Unknown') as title,
        coalesce(department, 'Unknown') as department,
        coalesce(lead_source, 'Unknown') as lead_source,
        coalesce(mailing_city, 'Unknown') as mailing_city,
        coalesce(mailing_country, 'Unknown') as mailing_country,
        owner_id,
        created_at,
        modified_at,
        {{ dbt_utils.generate_surrogate_key(['contact_id']) }} as contact_key
    from deduplicated
    where rn = 1
)

select * from cleaned
