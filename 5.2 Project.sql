--- Asher Macdonald
--- Q1 ---
SELECT userid
FROM userbase
MINUS
SELECT userid
FROM orders;

---  Q2 ---
SELECT productcode
FROM productlist
MINUS
SELECT productcode
FROM reviews;

---  Q3 ---
SELECT u.*,
       CASE
           WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, birthday) / 12) >= 18 THEN 'Adult'
           ELSE 'Minor'
       END AS age_group
FROM userbase u;

--- Q4 ---
SELECT p.*,
       CASE
           WHEN price <= 20 THEN 'On Sale'
           ELSE 'Base Price'
       END AS price_status
FROM productlist p;

--- Q5 ---
SELECT userid
FROM reviews
WHERE productcode = 'GAME6'

INTERSECT

SELECT userid
FROM userprofile
WHERE imagefile IS NOT NULL;

---  Q6 ---
SELECT productcode
FROM wishlist
WHERE position IN (1, 2)

INTERSECT

SELECT productcode
FROM reviews
WHERE rating >= 3;

--- Q7 ---
SELECT u1.username AS username1,
       u1.birthday AS birthday1,
       u2.username AS username2,
       u2.birthday AS birthday2
FROM userbase u1
JOIN userbase u2
     ON u1.birthday = u2.birthday
    AND u1.userid < u2.userid;

--- Q8 ---
SELECT *
FROM userlibrary
CROSS JOIN wishlist;

--- Q9 ---
SELECT TO_CHAR(userid) AS id,
       username AS name,
       'User' AS record_type
FROM userbase

UNION ALL

SELECT productcode AS id,
       productname AS name,
       'Product' AS record_type
FROM productlist;

--- Q10 ---
SELECT senderid AS userid,
       datesent AS activity_date,
       'Sent Message' AS activity_type
FROM chatlog

UNION ALL

SELECT userid,
       NULL AS activity_date,
       'Profile Created/Exists' AS activity_type
FROM userprofile;

---  Q11 ---
SELECT username
FROM userbase

MINUS

SELECT u.username
FROM userbase u
JOIN infractions i
    ON u.userid = i.userid;

--- Q12 ---
SELECT title, description
FROM communityrules

MINUS

SELECT c.title, c.description
FROM communityrules c
JOIN infractions i
    ON c.rulenum = i.rulenum;

--- Q13 ---
SELECT username, email
FROM userbase

INTERSECT

SELECT u.username, u.email
FROM userbase u
JOIN infractions i
    ON u.userid = i.userid
WHERE i.penalty IS NOT NULL;

--- Q14 ---
SELECT dateassigned
FROM infractions

INTERSECT

SELECT datesubmitted
FROM usersupport;

--- Q15 ---
SELECT c.title,
       i.penalty
FROM communityrules c
JOIN infractions i
     ON c.rulenum = i.rulenum;

--- Q16 ---
SELECT c.*,
       CASE
           WHEN severitypoint >= 10 THEN 'Bannable'
           ELSE 'Appealable'
       END AS rule_status
FROM communityrules c;

--- Q17 ---
SELECT u.*,
       CASE
           WHEN status <> 'Closed'
                AND dateupdated < SYSDATE - 7
           THEN 'High Priority'
           ELSE 'Normal'
       END AS priority_status
FROM usersupport u;

--- Q18 ---
SELECT *
FROM usersupport
CROSS JOIN infractions;

--- Q19 ---
SELECT u1.ticketid AS ticketid1,
       u1.dateupdated AS dateupdated1,
       u2.ticketid AS ticketid2,
       u2.dateupdated AS dateupdated2
FROM usersupport u1
JOIN usersupport u2
     ON TRUNC(u1.dateupdated) = TRUNC(u2.dateupdated)
    AND u1.ticketid < u2.ticketid
WHERE u1.status = 'CLOSED'
  AND u2.status = 'CLOSED';

--- Q20 ---
SELECT userid,
       username,
       'Account Created' AS activity_type,
       NULL AS activity_date
FROM userbase

UNION ALL

SELECT i.userid,
       u.username,
       'Infraction Issued' AS activity_type,
       i.dateassigned AS activity_date
FROM infractions i
JOIN userbase u
    ON i.userid = u.userid;