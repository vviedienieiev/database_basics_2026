# Practical Assignment: Indexes & Query Optimization

## Task 1 — EXPLAIN ANALYZE

### How PostgreSQL Executes a Query

When you run a query, PostgreSQL creates an **execution plan**.

---

### Without Index (Sequential Scan)

Query:

```sql
select *
from transactions
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

### Example with EXPLAIN ANALYZE

```sql
explain analyze
select *
from transactions
where account_id = 100;
```

Look for:

- `Seq Scan` → bad for large tables ❌  
- `Index Scan` → optimized query ✅  
- `Execution Time` → total time  

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
on transactions(account_id);
```

2. Run the same query again & Compare performance

---

## Task 4 — Composite Index

1. Create index on:
   - `(account_id, transaction_date)`

```sql
create index idx_transactions_account_date
on transactions(account_id, transaction_date);
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

## Task 6 — CTE Refactoring

Rewrite your query using a CTE:

1. Create CTE:
   - filtered transactions  

2. Select from it and apply sorting  
---

## Task 7 — CTE + Aggregation

Using `transactions`:

1. Create CTE:
   - total amount per account  

2. From it:
   - show top 10 accounts by total amount  

---

## Task 8 — Advanced Filtering

Write a query:

1. Find accounts using subquery or CTE:
   - with transactions above average  
---


## Graded Task (1 points)
You are given a slow query:

```sql
select
    c.customer_id,
    c.first_name,
    c.last_name,
    coalesce(c.email, 'no_email@example.com') as email,
    sum(t.amount) as total_amount,
    count(t.transaction_id) as transactions_count,
    round(avg(t.amount), 2) as avg_transaction_amount,
    max(t.amount) as max_transaction_amount,
    case
        when sum(t.amount) < 500 then 'low'
        when sum(t.amount) between 500 and 2000 then 'medium'
        else 'high'
    end as customer_value_category
from customers c
join accounts a on c.customer_id = a.customer_id
join transactions t on a.account_id = t.account_id
where t.transaction_date >= '2023-01-01'
and c.customer_id in (
    select a2.customer_id
    from accounts a2
    join transactions t2 on a2.account_id = t2.account_id
    group by a2.customer_id
    having count(t2.transaction_id) >= 3
)
group by c.customer_id, c.first_name, c.last_name, c.email
having sum(t.amount) > (
    select avg(customer_total)
    from (
        select sum(t3.amount) as customer_total
        from accounts a3
        join transactions t3 on a3.account_id = t3.account_id
        where t3.transaction_date >= '2023-01-01'
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
---

## Output

- optimized query  
- list of indexes  
- short explanation (2–3 sentences)
---
