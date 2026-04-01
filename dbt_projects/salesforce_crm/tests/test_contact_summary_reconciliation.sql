with direct_agg as (
    select
        account_id,
        count(*) as contact_count
    from {{ ref('int_contacts') }}
    where account_id is not null
    group by account_id
),
summary_table as (
    select
        account_id,
        total_contacts
    from {{ ref('int_account_contact_summary') }}
)
select
    direct_agg.account_id,
    direct_agg.contact_count,
    summary_table.total_contacts
from direct_agg
inner join summary_table
    on direct_agg.account_id = summary_table.account_id
where direct_agg.contact_count != summary_table.total_contacts
