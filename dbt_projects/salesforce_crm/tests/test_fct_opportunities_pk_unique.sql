select
    opportunity_id,
    count(*) as record_count
from {{ ref('fct_opportunities') }}
group by opportunity_id
having count(*) > 1
