with contacts as (
    select * from {{ ref('dim_contacts') }}
),

summary as (
    select
        account_id,
        count(*) as contact_count
    from contacts
    where account_id is not null
    group by account_id
)

select
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_contact_key,
    account_id,
    contact_count
from summary
