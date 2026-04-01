select
    c.contact_id,
    c.account_id
from {{ ref('slv_contacts') }} c
left join {{ ref('slv_accounts') }} a
    on c.account_id = a.account_id
where c.account_id is not null
  and a.account_id is null
