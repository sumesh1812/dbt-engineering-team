select
    opportunity_id,
    pipeline_stage
from {{ ref('fct_sales_pipeline') }}
where opportunity_id in (
    select opportunity_id
    from {{ ref('stg_opportunities') }}
    where is_open = false
)
