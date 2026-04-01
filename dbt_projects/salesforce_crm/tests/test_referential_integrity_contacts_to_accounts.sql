select
    c.contact_id,
    c.account_id
from {{ ref('dim_contacts') }} c
left join {{ ref('dim_accounts') }} a
    on c.account_id = a.account_id
where c.account_id is not null
    and a.account_id is null
