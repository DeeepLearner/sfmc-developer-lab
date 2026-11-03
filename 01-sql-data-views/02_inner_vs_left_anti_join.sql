/* 
Scenario: Find all Active customers from Delhi who have never placed an order.
Concept: Left Anti-Join using IS NULL filter to exclude existing purchasers.
*/
SELECT
c.SubscriberKey,
c.City
FROM Master_Customers as c
LEFT JOIN Orders_Data as o
ON c.SubscriberKey = o.SubscriberKey
WHERE c.Status = 'Active' AND c.City = 'Delhi'
AND o.OrderID IS NULL;
************************************************************************************************************
