select
    account_key,
    count(*) as duplicate_count
from {{ ref('int_accounts') }}
group by account_key
having count(*) > 1
