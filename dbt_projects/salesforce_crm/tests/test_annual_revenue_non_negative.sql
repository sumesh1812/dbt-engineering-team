select
    account_id,
    annual_revenue
from {{ ref('int_accounts') }}
where annual_revenue < 0
