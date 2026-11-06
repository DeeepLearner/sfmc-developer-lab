/*
Scenario: Extract the most recent login record per customer to prevent Primary Key violations.
Concept: Deduplication using ROW_NUMBER() window function partitioned by SubscriberKey.
*/

SELECT
c.SubscriberKey,
c.DeviceType,
c.LoginTime
FROM(
SELECT
SubscriberKey,
DeviceType,
LoginTime,
ROW_NUMBER() OVER (
PARTITION BY SubscriberKey
ORDER BY LoginTime
DESC) AS RowNum
FROM Customer_Logins
)AS c
WHERE c.RowNum = 1
*************************************************************************************************************************************************

/*
Extract the most recent record using DE duplication method, and partitioned by SubscriberKey, and Order by highest Order amount
*/

SELECT
x.Subscriberkey,
x.OrderNumber,
x.OrderAmount
FROM(
SELECT SubscriberKey,
OrderNumber,
OrderAmount,
ROW_NUMBER() OVER (PARTITION BY SubscriberKey ORDER BY OrderAmount DESC) AS RowNum
FROM Customer_Orders
) as x
WHERE x.Rownum = 1
*****************************************************************************************************************************************

/*IF 2 Subscriber have same amount of order then whats to do
Ans:- Just add one more column to remove duplicacy, by adding date column(who purchase highest on highest amount on most recent date basis)
*/

SELECT
x.Subscriberkey,
x.OrderNumber,
x.OrderAmount
FROM(
SELECT SubscriberKey,
OrderNumber,
OrderAmount,
ROW_NUMBER() OVER (PARTITION BY SubscriberKey ORDER BY OrderAmount DESC, OrderDate DESC) AS RowNum
FROM Customer_Orders
) as x
WHERE x.Rownum = 1
