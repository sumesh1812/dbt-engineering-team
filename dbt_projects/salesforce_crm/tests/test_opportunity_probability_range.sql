select
    opportunity_id,
    probability
from {{ ref('stg_opportunities') }}
where probability < 0 or probability > 100
