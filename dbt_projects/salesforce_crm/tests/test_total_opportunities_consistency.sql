select
    s.account_id,
    s.total_opportunities,
    s.open_opportunities,
    s.closed_won_opportunities,
    s.closed_lost_opportunities
from {{ ref('int_account_opportunity_summary') }} s
where s.total_opportunities != (
    s.open_opportunities + 
    s.closed_won_opportunities + 
    s.closed_lost_opportunities
)
