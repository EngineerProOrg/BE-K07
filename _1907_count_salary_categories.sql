with cte as (select 
    case
        when income <20000 then "Low Salary"
        when income > 50000 then "High Salary"
        else "Average Salary"
    end as category
    from Accounts
)

select category, count(category) as accounts_count
from cte group by category;