-- Calculate average monthly transactions per customer
-- and categorize them into frequency buckets

WITH monthly_tx AS (
    SELECT 
        owner_id,
        DATE_TRUNC('month', created_at) AS month,
        COUNT(*) AS monthly_count
    FROM 
        savings_savingsaccount
    GROUP BY 
        owner_id, DATE_TRUNC('month', created_at)
),
avg_tx_per_user AS (
    SELECT 
        owner_id,
        AVG(monthly_count) AS avg_tx
    FROM 
        monthly_tx
    GROUP BY owner_id
),
categorized AS (
    SELECT 
        CASE
            WHEN avg_tx >= 10 THEN 'High Frequency'
            WHEN avg_tx BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        owner_id,
        ROUND(avg_tx, 1) AS avg_transactions_per_month
    FROM avg_tx_per_user
)
SELECT 
    frequency_category,
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category
ORDER BY avg_transactions_per_month DESC;
