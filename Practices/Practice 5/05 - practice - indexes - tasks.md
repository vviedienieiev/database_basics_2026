# Practical Assignment: Indexes & Query Optimization

## Task 1 — EXPLAIN ANALYZE

### How PostgreSQL Executes a Query

When you run a query, PostgreSQL creates an **execution plan**.

---

### Without Index (Sequential Scan)

Query:

```sql
select *
from finance.transactions
where account_id = 100;
```

Execution plan (simplified):

```
Seq Scan on transactions
  ↓
Check every row
  ↓
Filter account_id = 100
  ↓
Return result
```

💡 Meaning:
- PostgreSQL reads the **entire table**
- Slow for large datasets

---

### With Index (Index Scan)

After creating index:

```sql
create index idx_transactions_account_id
on transactions(account_id);
```

Execution plan:

```
Index Scan using idx_transactions_account_id
  ↓
Find matching account_id quickly
  ↓
Return result
```

💡 Meaning:
- PostgreSQL uses index like a **search shortcut**
- Much faster than full scan

---


## Task 2 — Baseline Query

Using `transactions`:

1. Write a query:
   - filter transactions by `account_id`
   - filter by date range  
   - sort by `transaction_date`

2. Measure execution time (or observe query plan)
---


## Task 3 — Create Index

1. Create an index on:
   - `account_id`

```sql
create index idx_transactions_account_id
on finance.transactions(account_id);
```

2. Run the same query again & Compare performance

---

## Task 4 — Composite Index

1. Create index on:
   - `(account_id, transaction_date)`

```sql
create index idx_transactions_account_date
on finance.transactions(account_id, transaction_date);
```

2. Run query again & compare single column vs composite index

---

## Task 5 — Remove Index

1. Drop one of the indexes:

```sql
drop index idx_transactions_account_id;
```

2. Run query again  
---

## Task 8 — Covering Index Investigation

Using the `transactions` table:

1. Write the following query:

```sql
select
    account_id,
    amount,
    transaction_date
from finance.transactions
where account_id = 100;
```

2. Run:

```sql
explain analyze
```

and review the execution plan.

3. Create a composite index:

```sql
create index idx_transactions_covering
on finance.transactions(account_id, transaction_date, amount);
```

4. Run the same query again.

5. Compare:

* execution time;
* execution plan;
* whether PostgreSQL uses:

  * `Seq Scan`
  * `Index Scan`
  * `Index Only Scan`

### Questions

1. Which execution plan was used before creating the index?
2. Which execution plan was used after creating the index?
3. Did the query become faster after creating the index?
4. Why can a covering index be faster than a regular index?

---

## Task 6 — CTE + Aggregation

Using `transactions`:

1. Create CTE:
   - total amount per account  

2. From it:
   - show top 10 accounts by total amount  

---

## Task 7 — Advanced Filtering

Write a query:

1. Find accounts using subquery or CTE:
   - with transactions above average  
---


## Graded Task (1 points)
You are given a slow query:

```sql
select
    c.id as customer_id,
    split_part(c.full_name, ' ', 1) as first_name,
    split_part(c.full_name, ' ', 2) as last_name,
    coalesce(c.email, 'no_email@example.com') as email,
    sum(t.amount) as total_amount,
    count(t.id) as transactions_count,
    round(cast(avg(t.amount) as decimal(18,2)), 2) as avg_transaction_amount,
    max(t.amount) as max_transaction_amount,
    case
        when sum(t.amount) < 500 then 'low'
        when sum(t.amount) between 500 and 2000 then 'medium'
        else 'high'
    end as customer_value_category
from finance.customers c
join finance.accounts a on c.id = a.customer_id
join finance.transactions t on a.id = t.account_id
where t.created_at >= '2023-01-01'
and c.id in (
    select a2.customer_id
    from finance.accounts a2
    join finance.transactions t2 on a2.id = t2.account_id
    group by a2.customer_id
    having count(t2.id) >= 3
)
group by 1,2,3,4
having sum(t.amount) > (
    select avg(customer_total)
    from (
        select sum(t3.amount) as customer_total
        from finance.accounts a3
        join finance.transactions t3 on a3.id = t3.account_id
        where t3.created_at >= '2023-01-01'
        group by a3.customer_id
    ) totals
)
order by total_amount desc;
```

---

## Your goal

1. Optimize this query by:
   - adding appropriate indexes  
   - restructuring using CTE  
   - use better aliases 
   - Compare execution plans before and after optimization.
---

## Output

- optimized query  
- list of indexes  
- short explanation (2–3 sentences)
---
