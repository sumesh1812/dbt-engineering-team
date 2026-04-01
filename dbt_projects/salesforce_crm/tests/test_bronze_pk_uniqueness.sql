select
    account_id,
    count(*) as duplicate_count
from {{ ref('brz_sf_accounts') }}
group by account_id
having count(*) > 1
