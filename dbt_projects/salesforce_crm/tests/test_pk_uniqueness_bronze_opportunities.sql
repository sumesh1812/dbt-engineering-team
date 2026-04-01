select
    opportunity_id,
    count(*) as record_count
from {{ ref('stg_sf_opportunities') }}
group by opportunity_id
having count(*) > 1
