select
    account_id,
    count(*) as record_count
from {{ ref('stg_sf_accounts') }}
group by account_id
having count(*) > 1
