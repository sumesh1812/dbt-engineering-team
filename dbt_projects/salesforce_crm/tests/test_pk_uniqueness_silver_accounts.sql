select
    account_key,
    count(*) as record_count
from {{ ref('dim_accounts') }}
group by account_key
having count(*) > 1
