select
    opportunity_id,
    is_open,
    is_closed
from {{ ref('int_opportunities') }}
where is_open = true and is_closed = true
