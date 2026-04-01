with bronze_count as (
    select count(*) as row_count
    from {{ ref('stg_sf__contacts') }}
),
silver_count as (
    select count(*) as row_count
    from {{ ref('int_contacts') }}
)
select
    bronze_count.row_count as bronze_rows,
    silver_count.row_count as silver_rows
from bronze_count
cross join silver_count
where bronze_count.row_count != silver_count.row_count
