
# 📊 Data Analytics SQL Assessment

This repository contains SQL solutions to business-focused data analysis problems using a financial dataset. Each question solves a real-world scenario involving customer behavior, account activity, and value generation using SQL.

---

## 📁 Files Included

- `Assessment_Q1.sql` – High-Value Customers with Multiple Products  
- `Assessment_Q2.sql` – Transaction Frequency Categorization  
- `Assessment_Q3.sql` – Account Inactivity Alert  
- `Assessment_Q4.sql` – Customer Lifetime Value (CLV) Estimation

---

## ✅ Assessment_Q1: High-Value Customers with Multiple Products

**Objective**:  
Identify customers who have at least **one funded savings plan** and **one funded investment plan**, then sort them by their total deposits.

**Business Rationale**:  
Customers who engage with both savings and investment products are ideal for cross-selling opportunities like loans or credit products. Targeting these users helps maximize customer lifetime value.

**Approach**:
- Subqueries count distinct funded savings and investment plans.
- Transactions are filtered to only include plans with confirmed deposits.
- Total deposits are aggregated and converted from **Kobo to Naira**.
- Results are ordered by deposit volume in descending order.

📄 _[See Assessment_Q1.sql](./Assessment_Q1.sql)_

---

## ✅ Assessment_Q2: Transaction Frequency Analysis

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

📄 _[See Assessment_Q2.sql](./Assessment_Q2.sql)_

---

## ✅ Assessment_Q3: Account Inactivity Alert

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

📄 _[See Assessment_Q3.sql](./Assessment_Q3.sql)_

---

## ✅ Assessment_Q4: Customer Lifetime Value (CLV) Estimation

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

📄 _[See Assessment_Q4.sql](./Assessment_Q4.sql)_

---

## ✨ Notes

- All monetary values in the CLV and deposit calculations were originally in **Kobo** and converted to **Naira** where needed.
- Proper error handling like `NULLIF()` and `COALESCE()` was used to avoid divide-by-zero issues and handle missing data.
- All queries were written and tested for **MySQL compatibility**.
