select
    account_id,
    count(*) as duplicate_count
from {{ ref('int_accounts') }}
group by account_id
having count(*) > 1
