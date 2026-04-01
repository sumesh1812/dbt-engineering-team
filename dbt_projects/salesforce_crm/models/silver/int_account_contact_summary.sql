select
    account_id,
    count(*) as total_contacts,
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key
from {{ ref('int_contacts') }}
where account_id is not null
group by account_id
