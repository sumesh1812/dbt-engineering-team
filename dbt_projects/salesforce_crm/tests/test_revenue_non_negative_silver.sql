select
    opportunity_id,
    amount
from {{ ref('slv_opportunities') }}
where amount < 0
