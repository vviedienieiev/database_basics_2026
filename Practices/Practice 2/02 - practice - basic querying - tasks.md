# Practical Assignment: basic querying

## Task 1 — Basic SELECT

1. Show all customers  
2. Show only customers from `USA`  
3. Sort customers by `last_name` (A → Z)

---

## Task 2 — Aliases & Formatting

1. Show:
   - full name as `full_name`
   - split full name into first and last name. Name them `first_name`, `last_name` respectively


2. Show:
   - email in uppercase as `email_upper`

---

## Task 3 — Filtering with Conditions

Using `transactions`:

1. Show transactions where:
   - amount > 100  
   - country = 'USA'  

2. Show transactions between two dates  

3. Show deposit and withdrawal transactions

---

## Task 4 — Aggregations

1. Count total transactions  
2. Count transactions per `account_id`  
3. Show only accounts with more than 5 transactions  

---

## Task 5 — Sorting & Top Results

1. Show top 10 largest transactions  
2. Sort by amount descending  

---

## Task 6 — JOIN (basic)

Join:
- customers
- accounts  

Tasks:
1. Show customer name + account_id  
2. Show all customers even if they don’t have accounts  

---

## Task 7 — JOIN + Aggregation

Join:
- accounts
- transactions  

Tasks:
1. Count transactions per account  
2. Show only accounts with more than 5 transactions  

---



## Graded Task (1 points)

Write ONE query that:

1. Joins:
   - customers  
   - accounts  
   - transactions  

2. Calculates:
   - total transactions amount per customer  
   - average number of transactions per customer
   - first transaction time
   - number of accounts

3. Filters:
   - only customers with total amount > 1000  

4. Shows:
   - customer_id  
   - full name  
   - date of birth
   - all calculated metrics (p.2)

5. Sort:
   - by total amount (descending)
---
