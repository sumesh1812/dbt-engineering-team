select
    opportunity_id,
    stage_name
from {{ ref('stg_opportunities') }}
where stage_name is null
    or trim(stage_name) = ''
