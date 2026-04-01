select
    account_id,
    number_of_employees
from {{ ref('slv_accounts') }}
where number_of_employees < 0
