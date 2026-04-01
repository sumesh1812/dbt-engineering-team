select
    opportunity_id,
    is_closed,
    is_won,
    is_lost,
    opportunity_status
from {{ ref('int_opportunities') }}
where (is_won = true and opportunity_status != 'Won')
    or (is_lost = true and opportunity_status != 'Lost')
    or (is_closed = false and opportunity_status != 'Open')
