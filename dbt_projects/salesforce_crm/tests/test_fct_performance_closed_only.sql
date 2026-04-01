select
    performance_month,
    sales_rep_id,
    total_closed_opportunities
from {{ ref('fct_sales_performance') }}
where total_closed_opportunities < (won_opportunities + lost_opportunities)
