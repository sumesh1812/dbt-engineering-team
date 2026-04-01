with bronze_count as (
    select count(*) as cnt
    from {{ ref('stg_sf_opportunities') }}
),
silver_count as (
    select count(*) as cnt
    from {{ ref('fct_opportunities') }}
)
select
    b.cnt as bronze_count,
    s.cnt as silver_count,
    abs(b.cnt - s.cnt) as row_difference
from bronze_count b
cross join silver_count s
where b.cnt != s.cnt
