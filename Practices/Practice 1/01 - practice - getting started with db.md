# Practice 1: Getting Started with Databases (PostgreSQL + DBeaver)

## Goal
In this practice, you will:
- Install PostgreSQL
- Install DBeaver
- Connect to a database (with drivers)
- Create 1 table manually (DDL)
- Import 5 tables from CSV
- Run basic SQL queries (DML)
---

## Step 1: Install PostgreSQL

1. Go to the official website: https://www.postgresql.org/download/
2. Download the version for your OS
3. Run the installer
4. During installation:
   - Set a **password** (remember it!)
   - Default port: `5432` (leave as is)
5. Finish installation

---

## Step 2: Install DBeaver

1. Go to: https://dbeaver.io/download/
2. Download **DBeaver Community Edition**
3. Install and open the program

---

## Step 3: Connect to PostgreSQL

1. Open DBeaver
2. Click **"New Database Connection"**
3. Choose **PostgreSQL**

If prompted:
- Click **Download Driver**
- Wait until installation complete

4. Fill in:
   - Host: `localhost`
   - Port: `5432`
   - Database: `postgres`
   - Username: `postgres`
   - Password: *(the one you set earlier)*
5. Click **Test Connection**
6. Click **Finish**

---

## Step 4: Create a new database

```sql
create database banks;
```

Reconnect using database `banks`.

---

## 🗂️ Step 5: Create Schema

```sql
create schema finance;
```

💡 Structure:
- Database → `banks`
- Schema → `finance`
- Tables → inside schema
---


## Step 6: Create a Table (DDL)

```sql
create table finance.customers (
    customer_id int primary key,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(100),
    country varchar(100)
);
```

💡 Important:
- `varchar(100)` = text up to 100 characters
- always think about limits. Incorrect data types could lead to errors or insufficient usage of memory -> more costs.
---

# Step 7: Insert Data (Manual)

```sql
insert into finance.customers values
(1, 'John', 'Doe', 'john@mail.com', 'USA'),
(2, 'Anna', 'Smith', 'anna@mail.com', 'UK'),
(3, 'Ivan', 'Petrov', 'ivan@mail.com', 'Ukraine');
```

💡 This is manual way (good for testing)

---

## Step 8: DELETE vs TRUNCATE vs DROP

Understanding this is **critical**.

### DELETE → removes rows based on some codition
```sql
delete from finance.customers where customer_id = 1;
```

### TRUNCATE → removes ALL rows (fast)
```sql
truncate table finance.customers;
```

### DROP → removes table completely
```sql
drop table finance.customers;
```

💡 Summary:
- DELETE = data based on some codition
- TRUNCATE = all data
- DROP = structure + data

---


## Step 9: Import CSV Tables

Import the given banking data:
- accounts
- transactions
- cards
- loans
- merchants
- customers

### Steps:
1. Right click → Tables → Import Data
2. Select CSV
3. Create new table
4. Choose schema `finance`

---

### ⚠️ VERY IMPORTANT: Data Types

This is one of the most common mistakes beginners make.

You MUST adjust types manually:

| Data type | Use for |
|----------|--------|
| DATE | dates (transaction_date) |
| INTEGER / BIGINT | IDs |
| DECIMAL | money |
| VARCHAR(100) | text |

💡 Rules:
- Do NOT store dates as text 
- Do NOT leave everything as VARCHAR 
- Increase VARCHAR if needed (100 → 255)
---


## 🔍 Step 10: Queries

### View data
```sql
select * 
from finance.customers;
```

### View data
```sql
-- select only specified columns
select id,
    full_name,
    country
from finance.customers;
```

### Filter
```sql
-- select only specified columns
select *
from finance.customers
where country = 'USA';
```

### Aggregation
```sql
select account_id, count(*) as total_transactions
from finance.transactions
group by account_id;
```

### HAVING
```sql
select account_id, count(*) as total_transactions
from finance.transactions
group by account_id
having count(*) > 5;
```

### Sorting
```sql
select *
from finance.transactions
order by date_of_birth desc
```

---