select
    opportunity_id,
    days_to_close
from {{ ref('int_opportunities') }}
where days_to_close is not null
    and days_to_close < 0
