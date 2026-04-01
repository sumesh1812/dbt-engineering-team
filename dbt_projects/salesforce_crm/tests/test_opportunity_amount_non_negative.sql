select
    opportunity_id,
    amount
from {{ ref('stg_opportunities') }}
where amount < 0
