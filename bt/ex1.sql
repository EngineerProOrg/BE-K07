-- https://leetcode.com/problems/capital-gainloss/description/
select stock_name,
  sum(if(operation='Buy', -price, price)) as capital_gain_loss
from Stocks
group by stock_name
order by stock_name;


-- https://leetcode.com/problems/count-salary-categories/
(select 'Low Salary' as category, count(account_id) as accounts_count
from Accounts
where income < 20000)
union 
(select 'Average Salary' as category, count(account_id) as accounts_count
from Accounts
where income between 20000 and 50000)
union 
(select 'High Salary' as category, count(account_id) as accounts_count
from Accounts
where income > 50000);
