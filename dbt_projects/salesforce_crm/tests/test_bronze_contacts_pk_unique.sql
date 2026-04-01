select
    contact_id,
    count(*) as duplicate_count
from {{ ref('stg_sf__contacts') }}
group by contact_id
having count(*) > 1
