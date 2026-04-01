select
    opportunity_id,
    days_to_close,
    created_at,
    close_date
from {{ ref('slv_opportunities') }}
where days_to_close < 0
