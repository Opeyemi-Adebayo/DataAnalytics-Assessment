-- Q3: Flag savings and investment plans with no inflow transactions in the last 365 days

SELECT 
  p.id AS plan_id,                      -- Unique plan ID
  p.owner_id,                           -- Customer who owns the plan

  -- Label the plan type based on flags in the plans table
  CASE 
    WHEN p.is_regular_savings = 1 THEN 'Savings'
    WHEN p.is_a_fund = 1 THEN 'Investment'
    ELSE 'Unknown'                     -- Just in case neither flag is set
  END AS type,

  MAX(s.transaction_date) AS last_transaction_date,  -- Most recent inflow date
  DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days  -- Days since last inflow

FROM plans_plan p

-- Join transaction data (savings inflows)
LEFT JOIN savings_savingsaccount s ON s.plan_id = p.id

-- Only consider active plans (either savings or investment)
WHERE (p.is_regular_savings = 1 OR p.is_a_fund = 1)

-- Group by plan and owner to get the latest inflow date per plan
GROUP BY p.id, p.owner_id, type

-- Filter for plans that have:
-- - No inflow ever (NULL)
-- - OR the last inflow was more than 365 days ago
HAVING 
  last_transaction_date IS NULL
  OR last_transaction_date < CURDATE() - INTERVAL 365 DAY

-- Sort results by longest inactive plans first
ORDER BY inactivity_days DESC;









