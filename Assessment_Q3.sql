-- Identify savings or investment plans with no inflow
-- in the last 365 days

SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_a_fund = 1 THEN 'Investment'
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        ELSE 'Other'
    END AS type,
    MAX(s.created_at) AS last_transaction_date,
    DATE_PART('day', CURRENT_DATE - MAX(s.created_at)) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.owner_id = s.owner_id
GROUP BY 
    p.id, p.owner_id, p.is_a_fund, p.is_regular_savings
HAVING 
    MAX(s.created_at) < CURRENT_DATE - INTERVAL '365 days';
