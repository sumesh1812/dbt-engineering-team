with bronze_revenue as (
    select
        coalesce(sum(amount), 0) as total_revenue
    from {{ ref('stg_sf_opportunities') }}
),
silver_revenue as (
    select
        coalesce(sum(amount), 0) as total_revenue
    from {{ ref('fct_opportunities') }}
)
select
    b.total_revenue as bronze_total,
    s.total_revenue as silver_total,
    abs(b.total_revenue - s.total_revenue) as revenue_difference
from bronze_revenue b
cross join silver_revenue s
where abs(b.total_revenue - s.total_revenue) > 0.01
