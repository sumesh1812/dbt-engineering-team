select
    contact_id,
    count(*) as record_count
from {{ ref('brz_sf_contacts') }}
group by contact_id
having count(*) > 1
