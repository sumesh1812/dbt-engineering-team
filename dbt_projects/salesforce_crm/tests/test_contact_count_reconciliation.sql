with contact_counts as (
    select
        account_id,
        count(*) as calc_contact_count
    from {{ ref('dim_contacts') }}
    where account_id is not null
    group by account_id
),
summary_counts as (
    select
        account_id,
        contact_count
    from {{ ref('int_account_contact_summary') }}
)
select
    c.account_id,
    c.calc_contact_count,
    s.contact_count
from contact_counts c
inner join summary_counts s
    on c.account_id = s.account_id
where c.calc_contact_count != s.contact_count
