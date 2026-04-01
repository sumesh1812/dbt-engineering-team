select
    opportunity_id,
    count(*) as duplicate_count
from {{ ref('int_opportunities') }}
group by opportunity_id
having count(*) > 1
