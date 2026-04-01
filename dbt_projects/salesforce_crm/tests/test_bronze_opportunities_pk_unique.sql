select
    opportunity_id,
    count(*) as duplicate_count
from {{ ref('stg_sf__opportunities') }}
group by opportunity_id
having count(*) > 1
