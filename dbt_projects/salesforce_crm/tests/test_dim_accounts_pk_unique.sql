select
    account_id,
    count(*) as record_count
from {{ ref('dim_accounts') }}
group by account_id
having count(*) > 1
