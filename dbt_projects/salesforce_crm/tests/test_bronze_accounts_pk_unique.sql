select
    account_id,
    count(*) as duplicate_count
from {{ ref('stg_sf__accounts') }}
group by account_id
having count(*) > 1
