-- Q2: Categorize customers based on average monthly transaction frequency

-- Step 1: Count how many transactions each customer makes per month
WITH txn_per_month AS (
  SELECT 
    owner_id,
    DATE_FORMAT(transaction_date, '%Y-%m-01') AS txn_month,  -- Truncate date to the first of the month
    COUNT(*) AS txn_count                                    -- Count of transactions in that month
  FROM savings_savingsaccount
  GROUP BY owner_id, txn_month
),

-- Step 2: Calculate average number of monthly transactions per customer
monthly_avg AS (
  SELECT 
    owner_id,
    AVG(txn_count) AS avg_txn_per_month                     -- Average transactions per month
  FROM txn_per_month
  GROUP BY owner_id
),

-- Step 3: Categorize each customer based on their average transaction frequency
categorized AS (
  SELECT
    CASE 
      WHEN avg_txn_per_month >= 10 THEN 'High Frequency'    -- ≥10 transactions/month
      WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'  -- 3–9 transactions/month
      ELSE 'Low Frequency'                                  -- ≤2 transactions/month
    END AS frequency_category,
    avg_txn_per_month
  FROM monthly_avg
)

-- Step 4: Aggregate the number of customers in each frequency category
SELECT 
  frequency_category,                                       -- Frequency level
  COUNT(*) AS customer_count,                               -- Number of customers in each category
  ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month  -- Average across each category
FROM categorized
GROUP BY frequency_category;

