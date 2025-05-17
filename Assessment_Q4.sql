-- Calculate CLV based on customer tenure and transaction volume

WITH transaction_summary AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_amount
    FROM 
        savings_savingsaccount
    GROUP BY owner_id
),
user_tenure AS (
    SELECT 
        id AS customer_id,
        name,
        DATE_PART('month', AGE(CURRENT_DATE, date_joined)) AS tenure_months
    FROM users_customuser
),
combined AS (
    SELECT 
        u.customer_id,
        u.name,
        u.tenure_months,
        COALESCE(t.total_transactions, 0) AS total_transactions,
        ROUND(COALESCE(t.total_amount, 0) * 0.001 / 100, 2) AS avg_profit_per_transaction
    FROM user_tenure u
    LEFT JOIN transaction_summary t ON u.customer_id = t.owner_id
)
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND(
        CASE 
            WHEN tenure_months > 0 THEN (total_transactions::decimal / tenure_months) * 12 * avg_profit_per_transaction
            ELSE 0
        END, 2
    ) AS estimated_clv
FROM combined
ORDER BY estimated_clv DESC;
