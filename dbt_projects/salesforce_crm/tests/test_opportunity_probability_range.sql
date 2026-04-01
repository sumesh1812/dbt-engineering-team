select
    opportunity_id,
    probability
from {{ ref('fct_opportunities') }}
where probability < 0
    or probability > 100
