-- https://leetcode.com/problems/capital-gainloss/description/
SELECT
  stock_name,
  SUM(
    CASE
      WHEN operation = 'Buy' THEN - price
      ELSE price
    END
  ) AS capital_gain_loss
FROM
  Stocks
GROUP BY
  stock_name;

-- https://leetcode.com/problems/count-salary-categories/description/
SELECT
  categories.category,
  COUNT(Accounts.income) AS accounts_count
FROM
  (
    SELECT
      'Low Salary' AS category
    UNION
    SELECT
      'Average Salary'
    UNION
    SELECT
      'High Salary'
  ) categories
  LEFT JOIN Accounts ON (
    categories.category = 'Low Salary'
    AND Accounts.income < 20000
  )
  OR (
    categories.category = 'Average Salary'
    AND Accounts.income BETWEEN 20000 AND 50000
  )
  OR (
    categories.category = 'High Salary'
    AND Accounts.income > 50000
  )
GROUP BY
  categories.category;