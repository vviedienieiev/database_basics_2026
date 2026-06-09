# PostgreSQL Practice Tasks

## Task 1. Customer Balance Category (CTE, CASE WHEN, COALESCE)

A report needs to be created for all customers.

The result should contain the following columns:

```sql
customer_id,
full_name,
total_balance,
balance_category
```

Requirements:

* use a CTE to calculate the total balance for each customer;
* use `COALESCE` if a balance is missing;
* use `CASE WHEN` to determine the customer category.

Category logic:

```text
total_balance >= 20000 → high
total_balance >= 5000 → medium
otherwise → low
```

---

## Task 2. Largest Transaction per Account (Window Function)

The largest transaction for each account needs to be identified.

The result should contain the following columns:

```sql
account_id,
transaction_id,
amount,
created_at
```

Requirements:

* use `ROW_NUMBER()`;
* partition the data by account (`PARTITION BY account_id`);
* keep only the largest transaction for each account.

---

## Task 3. Account Balance Analysis (CTE, Window Function, CASE WHEN)

Account balances need to be analyzed and categorized.

The result should contain the following columns:

```sql
account_id,
balance,
avg_balance,
balance_difference,
account_status
```

Requirements:

* use a CTE;
* use the window function `AVG() OVER ()`;
* calculate the difference between the account balance and the average balance;
* use `CASE WHEN`.

Logic:

```text
balance > avg_balance → above_average
balance < avg_balance → below_average
otherwise → average
```

---

## Task 4. Function

A function needs to be created:

```sql
get_account_balance(p_account_id int)
```

The function should:

* accept an account ID;
* return the current account balance;
* return `0` if the account does not exist.

After creating the function, display:

```sql
account_id,
balance
```

using the created function.

---

## Task 5. View

A view needs to be created:

```sql
active_accounts_view
```

The view should contain:

```sql
account_id,
customer_id,
account_type,
balance,
status
```

Only active accounts should be included in the view.

After creating the view:

1. Query the view.
2. Count the number of active accounts.
3. Find the account with the highest balance using the view.

---

## Task 6. Procedure

A procedure needs to be created:

```sql
add_customer(
    p_first_name varchar,
    p_last_name varchar,
    p_email varchar
)
```

The procedure should insert a new customer into the `customers` table.

After creating the procedure:

1. Call the procedure to add a new customer.
2. Verify that the customer was successfully inserted.
3. Display the inserted customer's information.

Example call:

```sql
call add_customer(
    'John',
    'Smith',
    'john.smith@gmail.com'
);
```

Example verification:

```sql
select *
from finance.customers
where email = 'john.smith@gmail.com';
```

---

## Graded Task (1 Point)

1. Create a table named `inactive_accounts` and store all accounts with status `closed` in it.

2. Create a procedure:

```sql
activate_accounts()
```

The procedure should:

* find accounts with status `closed`;
* update their status to `active` if their balance is greater than 1000.

3. Execute the procedure.

4. Using the `inactive_accounts` table:

* determine how many accounts were updated;
* display all accounts that were activated.
