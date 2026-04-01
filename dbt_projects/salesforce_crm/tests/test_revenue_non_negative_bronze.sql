select
    opportunity_id,
    amount
from {{ ref('brz_sf_opportunities') }}
where amount < 0
