show databases;
create database Supplier17;
use Supplier17;
create table Supplier(
	sid int,
    sname varchar(30),
    address varchar(30),
    primary key (sid)
);
desc Supplier;
create table parts(
	pid int,
    pname varchar(30),
    color varchar(20),
    primary key (pid)
);
desc parts;
create table catalog(
	sid int,
    pid int,
	cost real,
    primary key (sid, pid),
	foreign key (sid) references Supplier(sid),
    foreign key (pid) references parts(pid)
);
desc catalog;
insert into Supplier values
	(192492, "Cello", "Bangalore"),
    (578209, "Tata Steel", "Jamshedpur"),
    (248795, "ITC", "Chennai"),
    (250235, "Dell", "Mumbai"),
    (830245, "JK Papers", "Delhi");
    
insert into parts values
	(100, "Paper" , "white"),
    (101, "Pen", "black"),
    (102, "Steel pipe", "grey"),
    (103, "Laptop", "black"),
    (104, "Biscuit", "brown"),
    (105, "Box", "red");
    
insert into catalog values
	(192492, 100, 230),
    (192492, 105, 30),
    (578209, 102, 950),
    (578209, 105, 35),
    (248795, 100, 210),
    (248795, 101, 10),
    (248795, 104, 25),
    (250235, 103, 40000),
    (830245, 100, 200);

select distinct Supplier.sid
from Supplier, parts, catalog
where Supplier.sid = catalog.sid AND parts.pid = catalog.pid AND (parts.color = "red" or parts.color = "black");

select distinct Supplier.sname, Supplier.address
from Supplier, parts, catalog
where Supplier.address = "Bangalore" OR (Supplier.sid=catalog.sid AND parts.pid=catalog.pid AND parts.color='Red');

select distinct C1.sid,C2.sid
from Catalog C1, Catalog C2
where C1.pid=C2.pid AND C1.cost>C2.cost AND C1.sid<>C2.sid;

-- 1. Find the pnames of parts for which there is some supplier
select distinct parts.pname
from parts, catalog
where parts.pid = catalog.pid;

-- ii. Find the snames of suppliers who supply every part.
select S.sname
from Supplier S
where S.sid = ANY (
	select sid
    from Catalog
    group by sid
    having count(sid) = (
			select count(*)
            from parts
		)
);

-- iii.Find the snames of suppliers who supply every red part.


-- iv. Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.


-- v. Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over all the suppliers who supply that part)
SELECT DISTINCT C.sid FROM Catalog C
 WHERE C.cost > ( SELECT AVG (C1.cost)
 FROM Catalog C1
 WHERE C1.pid = C.pid );


-- iii. Find the snames of suppliers who supply every red part.
-- iv. Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.
-- v. Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over 
-- all the suppliers who supply that part).
-- vi. For each part, find the sname of the supplier who charges the most for that part.
-- vii. Find the sids of suppliers who supply only red parts.

-- select distinct Supplier.sid 
-- from Supplier,Parts,Catalog
-- where Supplier.sid=Catalog.sid AND Parts.pid=Catalog.pid AND (Parts.color='Red' OR Parts.color='Green');
-- select distinct Supplier.sid
-- from Supplier,Parts,Catalog
-- where Supplier.city='Bangalore' OR (Supplier.sid=Catalog.sid AND Parts.pid=Catalog.pid AND Parts.color='Red');
-- select distinct C1.sid,C2.sid
-- from Catalog C1, Catalog C2
-- where C1.pid=C2.pid AND C1.cost>C2.cost AND C1.sid<>C2.sid;
-- select distinct Supplier.sid 
-- from Supplier,Parts,Catalog
-- where Supplier.sid=Catalog.sid AND Parts.pid=Catalog.pid AND Parts.color='Red';
-- select * from Supplier;
-- select * from Parts;
-- select * from Catalog;
