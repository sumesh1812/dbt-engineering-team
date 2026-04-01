select
    o.opportunity_id,
    o.account_id
from {{ ref('stg_sf__opportunities') }} o
left join {{ ref('stg_sf__accounts') }} a
    on o.account_id = a.account_id
where o.account_id is not null
    and a.account_id is null
