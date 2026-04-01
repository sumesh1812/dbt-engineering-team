select
    contact_id,
    count(*) as record_count
from {{ ref('stg_contacts') }}
group by contact_id
having count(*) > 1
