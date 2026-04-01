select
    opportunity_id,
    amount
from {{ ref('stg_sf__opportunities') }}
where amount is not null
    and amount < 0
