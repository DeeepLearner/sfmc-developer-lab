Project:- Marleting Manager wants to make a Data Extension in which the customers should have contacted by us thorugh Emails but they do not clicked any email once as well as not they purchased anything.
  Criteria: 
  1. Subscriber should have get the mail by last 30 days.
  2. Subscriber should not have clicked on any email(Non-Clicker)
  3. Susbcriber should not have purchased anything from Order_Master (New/Non-Buyer)
  4. In the Target DE every susbcriber should have strictly entered only 1 time with his LastSentDate
  DEs:   _Sent,   _Click,   Orders_Master

Query:---------------------------------------------------------------------------------------------------

SELECT
s.SubscriberKey,
MAX(s.EventDate) AS LastSentDate
FROM _Sent s
LEFT JOIN _Click c
ON s.SubscriberKey = c.SubscriberKey
AND c.EventDate >= DATEADD(DAY, -30, GETDATE())
LEFT JOIN Orders_Master ord
ON s.SubscriberKey = ord.SubscriberKey
WHERE s.EventDate >= DATEADD(DAY, -30, GETDATE())
AND c.SubscriberKey IS NULL
AND ord.SubscriberKey IS NULL
GROUP BY
s.SubscriberKey;
************************************************************************************************************
