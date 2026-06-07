# Practical Assignment: advanced querying

## Task 1 — CASE WHEN

Using `transactions`:

Create a column `amount_category`:

- amount < 50 → 'small'  
- amount between 50 and 200 → 'medium'  
- amount > 200 → 'large'  

---

## Task 2 — CASE WHEN

Using `accounts`:

Create column `account_status`:

- balance > 1000 → 'premium'  
- balance between 100 and 1000 → 'standard'  
- else → 'low'  

---

## Task 3 — COALESCE

Using `customers`:

1. Replace NULL emails with 'no_email@example.com'  
2. Show 'Unknown' if `full_name` is NULL  

---

## Task 4 — CTE

Using `transactions`:

1. Create a CTE that calculates total amount per account  
2. From that CTE show only accounts with total > 500  

---

## Task 5 — CTE + JOIN
1. Create a CTE that calculates:
   - total transaction amount per account  
   - number of transactions per account  

2. Join this CTE with the `accounts` table  

3. Show:
   - account_id  
   - total_amount  
   - transactions_count  
   - account balance  

4. Sort result by:
   - total_amount descending  

---

## Task 6 — Window Function (ROW_NUMBER)

Using `transactions`:

Assign row number per account ordered by amount DESC  

---

## Task 7 — Window Function (RANK)

1. Rank transactions by amount (global)  
2. Rank transactions inside each account  

---

## Task 8 — Window Function (Running Total)

Using `transactions`:

1. Create a first CTE `base_transactions`:
   - select all transactions
   - keep: `account_id`, `amount`, `transaction_date`

2. Create a second CTE `ranked_transactions`:
   - use a window function to assign:
     - row number per account  
     - ordered by amount DESC  

3. From the final result show:
   - account_id  
   - amount  
   - row_number  

4. Show only:
   - top 3 transactions per account  

---

## Graded Task (2 points)

Write **ONE query** using **2–3 CTEs**.

### Required logic

1. Create CTE `customer_accounts`:
   - join `customers` with `accounts`
   - show customer and account information

2. Create CTE `account_transactions`:
   - calculate per account:
     - total transaction amount
     - number of transactions
     - average transaction amount

3. Create final CTE `account_analysis`:
   - join `customer_accounts` with `account_transactions`
   - use `COALESCE` for missing transaction values
   - use `CASE WHEN` to create `activity_level`
   - use window function to rank accounts by total amount

---

## Output

Show:

- account_id
- customer_id
- full_name
- balance
- total_amount
- transactions_count
- average_transaction_amount
- activity_level
- rank

Sort by:

- total_amount DESC

### Activity levels

- transactions_count = 0 → 'no activity'
- transactions_count between 1 and 3 → 'low activity'
- transactions_count between 4 and 7 → 'medium activity'
- transactions_count > 7 → 'high activity'

---

