select
    opportunity_key,
    count(*) as record_count
from {{ ref('fct_opportunities') }}
group by opportunity_key
having count(*) > 1
