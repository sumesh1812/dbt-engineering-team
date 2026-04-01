select
    o.opportunity_id,
    o.account_id
from {{ ref('fct_opportunities') }} o
left join {{ ref('dim_accounts') }} a
    on o.account_id = a.account_id
where o.account_id is not null
    and a.account_id is null
