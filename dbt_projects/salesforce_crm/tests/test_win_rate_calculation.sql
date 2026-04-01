select
    account_id,
    closed_won_opportunities,
    closed_lost_opportunities,
    account_win_rate
from {{ ref('int_account_opportunity_summary') }}
where (closed_won_opportunities + closed_lost_opportunities) > 0
  and account_win_rate is null
