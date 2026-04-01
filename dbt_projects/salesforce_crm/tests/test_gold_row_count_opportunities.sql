with silver_count as (
    select count(*) as slv_count
    from {{ ref('slv_opportunities') }}
),
gold_count as (
    select count(*) as gld_count
    from {{ ref('fct_opportunities') }}
)
select
    slv_count,
    gld_count,
    abs(slv_count - gld_count) as row_diff
from silver_count
cross join gold_count
where slv_count != gld_count
