select
    contact_id,
    count(*) as duplicate_count
from {{ ref('int_contacts') }}
group by contact_id
having count(*) > 1
