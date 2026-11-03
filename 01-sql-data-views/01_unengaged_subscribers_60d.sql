Question 1:- Humein ek aisi target Data Extension populate karni hai jisme wo subscribers aayein jinhe pichle 60 dino me koi bhi email bheja gaya tha (_Sent), lekin unhone un 60 dino me ek baar bhi open nahi kiya (_Open).

Query-------------
SELECT
s.SubscriberKey,
sub.EmailAddress,
MAX(s.EventDate) AS LastSentDate
FROM _Sent s
INNER JOIN _Subscribers sub
ON s.SubscriberKey = sub.SubscriberKey
LEFT JOIN _Open o
ON s.SubscriberKey = o.SubscriberKey
AND o.EventDate >= DATEADD(DAY, -60, GETDATE())
WHERE s.EventDate = DATEADD(DAY, -60, GETDATE())
AND o.SubscriberKey IS NULL
*******************************************************************************************************************************************
Question 2:- Humein un logon ki list chahiye jinhone pichle 30 dino me kisi email par Click kiya hai (_Click data view).
Output columns: SubscriberKey, JobID, EventDate (Click date).

Query-------------
SELECT
SubscriberKey,
JobID,
EventDate AS ClickDate
FROM _Click
WHERE EventDate >= DATEADD(DAY, -30, GETDATE())
AND ISUNIQUE = 1;
********************************************************************************************************************************************
Question 3:- Humein un logon ki SubscriberKey chahiye jo Delhi me rehte hain (City = 'Delhi') aur jinka status Active hai (Status = 'Active')

Query---------------
SELECT
SubscriberKey,
Status,
City
FROM Master_Customers
WHERE City = 'Delhi' AND Status = 'Active';
***********************************************************************************************************************************************
Question 4:- Master_Customers
Columns: SubscriberKey, City, Status
Orders_Data
Columns: SubscriberKey, OrderID, OrderAmount
Requirement:

Humein un customers ka data chahiye jo Delhi ke hain (City = 'Delhi'), jinka status Active hai (Status = 'Active'), aur jinhone order place kiya hai (yani jo dono tables me match hote hon).
Output me kya chahiye:
SubscriberKey, City, OrderID, OrderAmount.

  Query-----------------
SELECT
c.SubscriberKey,
c.City,
o.OrderID,
o.OrderAmount
FROM Master_Customers as c
INNER JOIN Orders_Data as o
ON c.SubscriberKey = o.SubscriberKey
WHERE c.City = 'Delhi' AND c.Status = 'Active';
**************************************************************************************************************************************************
