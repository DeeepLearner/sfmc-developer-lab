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
WHERE c.RowNum = 1;
