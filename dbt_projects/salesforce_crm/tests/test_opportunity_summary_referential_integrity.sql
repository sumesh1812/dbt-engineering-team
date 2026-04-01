select
    s.account_id
from {{ ref('int_account_opportunity_summary') }} s
left join {{ ref('slv_accounts') }} a
    on s.account_id = a.account_id
where a.account_id is null
