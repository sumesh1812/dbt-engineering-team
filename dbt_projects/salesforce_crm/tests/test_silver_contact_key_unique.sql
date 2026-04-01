select
    contact_key,
    count(*) as duplicate_count
from {{ ref('int_contacts') }}
group by contact_key
having count(*) > 1
