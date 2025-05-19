SELECT * FROM plans_plan;
SELECT * FROM savings_savingsaccount;
SELECT * FROM users_customuser;
SELECT * FROM withdrawals_withdrawal;


-- Q1: Customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits

SELECT 
  u.id AS owner_id,
  CONCAT(u.first_name, ' ', u.last_name) AS name,  -- Combine first and last name
  savings.savings_count,                          -- Count of funded savings plans
  investments.investment_count,                   -- Count of funded investment plans
  FORMAT(deposits.total_deposits / 100, 2) AS total_deposits  -- Total deposits converted from Kobo to Naira, formatted with commas
FROM users_customuser u

-- Subquery to count funded savings plans per customer
JOIN (
    SELECT 
      p.owner_id, 
      COUNT(DISTINCT p.id) AS savings_count
    FROM plans_plan p
    JOIN savings_savingsaccount s ON s.plan_id = p.id
    WHERE 
      p.is_regular_savings = 1     -- Only regular savings plans
      AND s.confirmed_amount > 0   -- Must have deposits
    GROUP BY p.owner_id
) AS savings ON u.id = savings.owner_id

-- Subquery to count funded investment plans per customer
JOIN (
    SELECT 
      p.owner_id, 
      COUNT(DISTINCT p.id) AS investment_count
    FROM plans_plan p
    JOIN savings_savingsaccount s ON s.plan_id = p.id
    WHERE 
      p.is_a_fund = 1              -- Only investment (fund) plans
      AND s.confirmed_amount > 0   -- Must have deposits
    GROUP BY p.owner_id
) AS investments ON u.id = investments.owner_id

-- Subquery to sum total deposits (confirmed_amount) per customer
JOIN (
    SELECT 
      p.owner_id, 
      SUM(s.confirmed_amount) AS total_deposits
    FROM plans_plan p
    JOIN savings_savingsaccount s ON s.plan_id = p.id
    WHERE 
      s.confirmed_amount > 0       -- Only funded transactions
    GROUP BY p.owner_id
) AS deposits ON u.id = deposits.owner_id

-- Sort customers by total deposits (in Kobo, so order by raw sum)
ORDER BY deposits.total_deposits DESC;
