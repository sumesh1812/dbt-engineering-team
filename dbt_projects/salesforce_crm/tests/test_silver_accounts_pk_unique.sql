select
    account_id,
    count(*) as record_count
from {{ ref('stg_accounts') }}
group by account_id
having count(*) > 1
