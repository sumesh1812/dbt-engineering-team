select
    opportunity_id,
    is_closed,
    is_open
from {{ ref('fct_opportunities') }}
where (is_closed = true and is_open = true)
    or (is_closed = false and is_open = false)
