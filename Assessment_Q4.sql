-- Q4: Estimate Customer Lifetime Value (CLV) based on account tenure and transaction volume
-- Assumption: Profit per transaction = 0.1% of average transaction value (in Naira)

SELECT 
  u.id AS customer_id,  -- Unique ID of the customer
  CONCAT(u.first_name, ' ', u.last_name) AS name,  -- Full name by combining first and last name
  TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,  -- Customer tenure in months
  COUNT(s.id) AS total_transactions,  -- Total number of inflow transactions by the customer

  -- CLV formula:
  -- CLV = (total_transactions / tenure_months) * 12 * (average_transaction_value * 0.1%)
  -- Divide confirmed_amount by 100 to convert from Kobo to Naira
  ROUND(((COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * ((AVG(s.confirmed_amount / 100)) * 0.001)), 2) AS estimated_clv  -- Final estimated CLV in Naira, rounded to 2 decimal places
FROM users_customuser u

-- Link each user to their transactions
LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id

-- Group by customer to aggregate CLV metrics
GROUP BY u.id, name

-- Show customers with the highest CLV first
ORDER BY estimated_clv DESC;

