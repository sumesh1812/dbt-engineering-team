select
    opportunity_id,
    is_closed,
    is_won,
    is_lost,
    is_open
from {{ ref('stg_opportunities') }}
where (is_won = true and is_closed = false)
    or (is_lost = true and is_closed = false)
    or (is_open = true and is_closed = true)
    or (is_won = true and is_lost = true)
