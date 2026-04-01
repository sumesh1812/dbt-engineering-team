select
    account_id,
    annual_revenue
from {{ ref('slv_accounts') }}
where annual_revenue < 0
