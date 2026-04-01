select
    account_id
from {{ ref('int_account_opportunity_summary') }}
where account_id is null
