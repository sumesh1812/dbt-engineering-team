with bronze_count as (
    select count(*) as brz_count
    from {{ ref('brz_sf_opportunities') }}
),
silver_count as (
    select count(*) as slv_count
    from {{ ref('slv_opportunities') }}
)
select
    brz_count,
    slv_count,
    abs(brz_count - slv_count) as row_diff
from bronze_count
cross join silver_count
where brz_count != slv_count
