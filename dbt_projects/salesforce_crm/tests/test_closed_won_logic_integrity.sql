select
    opportunity_id,
    is_closed,
    is_won,
    is_lost
from {{ ref('int_opportunities') }}
where is_won = true and is_closed = false
