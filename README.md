# Data Analytics Assessment – SQL Proficiency

## Overview
This repository contains solutions to four SQL tasks designed to test my ability to retrieve, analyze, and manipulate data from a relational database system. I focused on clarity, correctness, and using efficient query structures.

---

## Question 1: High-Value Customers with Multiple Products

**Goal:** Find customers who have at least one savings plan and one investment plan.

**Approach:**  
I joined the users, savings, and plans tables. Then I filtered savings where `is_regular_savings = 1` and plans where `is_a_fund = 1`. I used `GROUP BY` and `HAVING` to count only customers who have both.

---

## Question 2: Transaction Frequency Analysis

**Goal:** Group customers into frequency categories based on their transaction activity.

**Approach:**  
I calculated total transactions and averaged them per month. Then I used `CASE WHEN` logic to assign a category: High, Medium, or Low frequency. Grouped the results and used `COUNT` and `AVG`.

---

## Question 3: Account Inactivity Alert

**Goal:** Identify accounts with no inflow for over one year.

**Approach:**  
I compared the most recent transaction date with today’s date using `DATEDIFF`. I filtered for accounts with no deposits in the last 365 days.

---

## Question 4: Customer Lifetime Value (CLV)

**Goal:** Estimate CLV for each customer based on tenure and transaction volume.

**Approach:**  
I calculated tenure in months using the signup date. Then I computed total transactions and used the given formula to calculate CLV, assuming a 0.1% profit per transaction.

---

## Challenges I Faced

- Making sure all join conditions were correct so that rows weren't duplicated.
- Proper handling of dates across multiple tables and calculating time differences.
- Ensuring clear and readable query structure to avoid confusion.

---

## Conclusion

All queries were tested for performance and clarity. I wrote them to be understandable and efficient for real-world use.
