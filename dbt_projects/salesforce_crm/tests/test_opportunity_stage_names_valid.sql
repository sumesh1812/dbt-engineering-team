select
    opportunity_id,
    stage_name
from {{ ref('fct_opportunities') }}
where stage_name is null
    or trim(stage_name) = ''
