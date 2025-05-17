-- Find customers who have both savings and investment plans
-- and show total deposits

SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
JOIN 
    plans_plan p ON u.id = p.owner_id
WHERE 
    s.is_regular_savings = 1
    AND p.is_a_fund = 1
GROUP BY 
    u.id, u.name
HAVING 
    COUNT(DISTINCT s.id) >= 1 
    AND COUNT(DISTINCT p.id) >= 1
ORDER BY 
    total_deposits DESC;
