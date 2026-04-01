select
    o.opportunity_id,
    o.account_id
from {{ ref('int_opportunities') }} o
left join {{ ref('int_accounts') }} a
    on o.account_id = a.account_id
where o.account_id is not null
    and a.account_id is null
