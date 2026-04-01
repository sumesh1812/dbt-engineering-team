with bronze_count as (
    select count(*) as bronze_rows
    from {{ ref('brz_sf_opportunities') }}
),
silver_count as (
    select count(*) as silver_rows
    from {{ ref('stg_opportunities') }}
)
select
    bronze_rows,
    silver_rows,
    abs(bronze_rows - silver_rows) as row_difference
from bronze_count
cross join silver_count
where abs(bronze_rows - silver_rows) > (bronze_rows * 0.05)
