select
    opportunity_id,
    is_closed,
    is_won,
    is_lost
from {{ ref('int_opportunities') }}
where is_lost = true and is_closed = false
