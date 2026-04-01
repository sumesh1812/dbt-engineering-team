select
    account_id,
    count(*) as total_opportunities,
    sum(case when is_open then 1 else 0 end) as open_opportunities,
    sum(case when is_won then 1 else 0 end) as won_opportunities,
    sum(case when is_lost then 1 else 0 end) as lost_opportunities,
    sum(case when is_open then amount else 0 end) as total_pipeline_value,
    sum(case when is_won then amount else 0 end) as total_won_value,
    sum(case when is_lost then amount else 0 end) as total_lost_value,
    case
        when sum(case when is_won then 1 else 0 end) + sum(case when is_lost then 1 else 0 end) > 0
        then (sum(case when is_won then 1 else 0 end)::float / 
              (sum(case when is_won then 1 else 0 end) + sum(case when is_lost then 1 else 0 end))) * 100
        else null
    end as win_rate,
    {{ dbt_utils.generate_surrogate_key(['account_id']) }} as account_key
from {{ ref('int_opportunities') }}
where account_id is not null
group by account_id
