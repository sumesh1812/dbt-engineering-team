select
    o.opportunity_id,
    o.account_id
from {{ ref('slv_opportunities') }} o
left join {{ ref('slv_accounts') }} a
    on o.account_id = a.account_id
where o.account_id is not null
  and a.account_id is null
