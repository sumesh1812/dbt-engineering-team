select
    opportunity_id,
    amount
from {{ ref('fct_opportunities') }}
where amount < 0
