with bronze_revenue as (
    select
        sum(coalesce(amount, 0)) as total_revenue
    from {{ ref('stg_sf__opportunities') }}
    where is_won = true
),
silver_revenue as (
    select
        sum(amount) as total_revenue
    from {{ ref('int_opportunities') }}
    where is_won = true
)
select
    bronze_revenue.total_revenue as bronze_total,
    silver_revenue.total_revenue as silver_total,
    abs(bronze_revenue.total_revenue - silver_revenue.total_revenue) as variance
from bronze_revenue
cross join silver_revenue
where abs(bronze_revenue.total_revenue - silver_revenue.total_revenue) > 0.01
