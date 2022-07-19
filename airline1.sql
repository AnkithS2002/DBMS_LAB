/*
Consider the following database that keeps track of airline flight information:
FLIGHTS (flno: integer, from: string, to: string, distance: integer, departs: time, arrives: time, price: integer)
AIRCRAFT (aid: integer, aname: string, cruisingrange: integer)
CERTIFIED (eid: integer, aid: integer)
EMPLOYEE (eid: integer, ename: string, salary: integer)
Note that the Employees relation describes pilots and other kinds of employees as well; Every pilot is certified
for some aircraft, and only pilots are certified to fly.
Write each of the following queries in SQL.
i. Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000.
ii. For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising range of
the aircraft for which she or he is certified.
iii. Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to
Frankfurt.
iv. For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average salary of
all pilots certified for this aircraft.
v. Find the names of pilots certified for some Boeing aircraft.
vi. Find the aids of all aircraft that can be used on routes from Bengaluru to New Delhi.
vii. A customer wants to travel from Madison to New York with no more than two changes of flight. List the
choice of departure times from Madison if the customer wants to arrive in New York by 6 p.m.
viii. Print the name and salary of every non-pilot whose salary is more than the average salary for pilots.
*/

show databases;
use airline1;
show tables;
desc aircraft;
select * from aircraft;
select * from certified;
select * from employees;
select * from flights;

-- QUERIES:
-- i. Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000.
 SELECT DISTINCT aname 
 FROM aircraft A, certified C, employees E
 WHERE  E.salary > 80000 AND
		E.eid = C.eid AND 
        A.aid = C.aid;
        
-- ii. For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising range of
-- the aircraft for which she or he is certified.

SELECT 
    E.eid, MAX(cruisingrange)
FROM
    aircraft A,
    certified C,
    employees E
WHERE
    E.eid IN (SELECT 
            d.eid
        FROM
            certified d
        GROUP BY d.eid
        HAVING COUNT(d.eid) > 3);

-- iii. Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to
-- Frankfurt.
SELECT E.ename
From employees E
WHERE E.salary < (
			select min(price)
            from flights
            where ffrom = "Bangalore" AND fto = "Frankfurt"
);

-- iv. For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average salary of
-- all pilots certified for this aircraft.
