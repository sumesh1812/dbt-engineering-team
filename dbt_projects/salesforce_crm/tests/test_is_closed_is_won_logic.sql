select
    opportunity_id,
    is_closed,
    is_won
from {{ ref('slv_opportunities') }}
where is_won = true
  and is_closed = false
