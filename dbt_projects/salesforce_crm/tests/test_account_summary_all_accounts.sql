with all_accounts as (
    select account_id
    from {{ ref('stg_accounts') }}
),
accounts_in_summary as (
    select account_id
    from {{ ref('int_account_opportunity_summary') }}
)
select
    a.account_id
from all_accounts a
left join accounts_in_summary s
    on a.account_id = s.account_id
where s.account_id is null
