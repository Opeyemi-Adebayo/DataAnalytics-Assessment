
#  Data Analytics SQL Assessment

This repository contains SQL solutions to business-focused data analysis problems using a financial dataset. Each question solves a real-world scenario involving customer behavior, account activity, and value generation using SQL.

---

##  Files Included

- `Assessment_Q1.sql` – High-Value Customers with Multiple Products  
- `Assessment_Q2.sql` – Transaction Frequency Categorization  
- `Assessment_Q3.sql` – Account Inactivity Alert  
- `Assessment_Q4.sql` – Customer Lifetime Value (CLV) Estimation

---

##  Assessment_Q1: High-Value Customers with Multiple Products

**Objective**:  
Identify customers who have at least **one funded savings plan** and **one funded investment plan**, then sort them by their total deposits.

**Business Rationale**:  
Customers who engage with both savings and investment products are ideal for cross-selling opportunities like loans or credit products. Targeting these users helps maximize customer lifetime value.

**Approach**:
- Subqueries count distinct funded savings and investment plans.
- Transactions are filtered to only include plans with confirmed deposits.
- Total deposits are aggregated and converted from **Kobo to Naira**.
- Results are ordered by deposit volume in descending order.

This question seeks to determine customers who have both savings and an investment for cross-selling opportunities because such customers would likely consider more services that the company could be offering, such as mortgages, credit services, etc.  Since the goal is to sort the customers by total deposits, the code is written to select customer based on their owner IDs using u.id, name of the customer using their first and last name, the saving and investment count and their total deposits, this first block of code is link to the second and third block that ensures that the customer have a regular savings (is_regular_savings=1) and amount of saving is greater than zero(this actaully confirms if the has a saving plan), then the savings_plan is counted based on this because been regular is sign that the person has a saving plan, the same was done for the investment paln using "is_a_fund" =1 as a check, then total deposits across their accounts are calculated in the last block of code, and they are now ordered by their total deposits.

---

##  Assessment_Q2: Transaction Frequency Analysis

**Objective**:  
Classify customers into **High**, **Medium**, or **Low Frequency** groups based on the **average number of transactions per month**.

**Business Rationale**:  
Understanding customer transaction behavior enables personalized engagement, retention campaigns, and predictive analytics on customer value.

**Approach**:
- Transactions are grouped by customer and month.
- Monthly averages are computed per customer.
- Customers are categorized:
  - High: ≥10 transactions/month  
  - Medium: 3–9 transactions/month  
  - Low: ≤2 transactions/month
- The final result shows the number of customers in each category and their average activity.

Understanding customers’ transaction behaviors is essential for identifying promising investment opportunities and determining which clients warrant special attention, this code has four segements; the first block gets owner id which is a foreign key to the primary key ID in the users table and transaction dates; while the second block gets the owner id and the average transaction per month, then this details are categorized into high (≥10 transactions/month), medium (3-9 transactions/month) and low frequency (≤2 transactions/month) based on the given criteria in the third block. The last block gets the number of customers based on the categories and the average transactions per month.

---

##  Assessment_Q3: Account Inactivity Alert

**Objective**:  
Flag active **savings** or **investment** accounts with **no inflow transactions** in the last **365 days**.

**Business Rationale**:  
Monitoring dormant accounts can help identify disengaged customers and reduce churn through targeted reactivation efforts.

**Approach**:
- Filters plans where `is_regular_savings = 1` or `is_a_fund = 1`.
- Joins each plan to its inflow transaction records.
- Calculates the most recent transaction date and days since that date.
- Flags accounts with:
  - No transactions at all (`NULL`)
  - Last transaction more than a year ago

This query is centered on getting the details of customers that have active accounts but with transactions, because this could aid the business to get key details on customers that might be losing interest in the services that the company offers, possibly to reduce the churning rate. The first step is identify all the savings and investments plan that is present within the database based on finding all the customers with is_regular_savings =1 and is_a_fund =1 and additional criteria 'Unknown" to prevent the code from breaking and to capture all other catefgories of customer that does not have savings and investment plans. Then the current date is compared with the last transaction date to calculate the inactivity days, then customers are grouped by those that have no transactions or that have no transactions in the last 1 year.

---

##  Assessment_Q4: Customer Lifetime Value (CLV) Estimation

**Objective**:  
Estimate **Customer Lifetime Value** using:
- Tenure in months since signup
- Total number of inflow transactions
- Average transaction value
- Profit assumption: 0.1% of average transaction value

**Business Rationale**:  
CLV is a key metric for measuring a customer's long-term value to the business. It supports better resource allocation and customer segmentation strategies.

**Approach**:
- Uses `TIMESTAMPDIFF` to calculate tenure.
- Counts transactions and computes average confirmed amounts (converted from Kobo to Naira).
- Applies a simplified CLV formula:
  CLV = (total_transactions / tenure_months) × 12 × (avg_transaction_value × 0.001)
- Results are ordered by CLV in descending order.

This question is focused on estimating a key metric, which is the customer lifetime value, to know the relative performance or loyalty of the customer to the business assuming the porfit_per_tansaction is 0.1% of the transcation value, so the company can determine how to address the different customers adequately in order not to lose a loyal customer.  The first block of the query gets the total transactions and average transaction value from the savings account and groups by the owner ID,  then the second block evaluates the account tenure, which is the number of months since signup. By selecting the customers by customer ID, their name, and TIMESTAMPDIFF is used to evaluate their account tenure by finding the difference between the date they joined and the current date. The third block was used to evaluate the CLV by dividing the total transactions by the tenure, and then multiplying by 12 and the average transaction value. All the required values are now selected from the CLV calculations and ordered by the estimated CLV from the highest to the lowest value.

---

##  Notes

- All monetary values in the CLV and deposit calculations were originally in **Kobo** and converted to **Naira** where needed.
- Proper error handling like `NULLIF()` and `COALESCE()` was used to avoid divide-by-zero issues and handle missing data.
- All queries were written and tested for **MySQL compatibility**.
