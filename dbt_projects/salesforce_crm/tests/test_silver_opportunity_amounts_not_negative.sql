select
    opportunity_id,
    amount
from {{ ref('int_opportunities') }}
where amount < 0
