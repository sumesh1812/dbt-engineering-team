select
    opportunity_id,
    probability
from {{ ref('slv_opportunities') }}
where probability < 0 or probability > 100
