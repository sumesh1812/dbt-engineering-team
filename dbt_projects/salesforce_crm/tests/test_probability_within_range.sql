select
    opportunity_id,
    probability
from {{ ref('stg_sf__opportunities') }}
where probability is not null
    and (probability < 0 or probability > 100)
