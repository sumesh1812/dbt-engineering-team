select
    contact_key,
    count(*) as record_count
from {{ ref('dim_contacts') }}
group by contact_key
having count(*) > 1
