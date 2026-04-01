select
    account_id,
    lifetime_won_revenue_usd,
    lifetime_lost_value_usd,
    current_pipeline_value_usd
from {{ ref('dim_accounts') }}
where lifetime_won_revenue_usd < 0
    or lifetime_lost_value_usd < 0
    or current_pipeline_value_usd < 0
