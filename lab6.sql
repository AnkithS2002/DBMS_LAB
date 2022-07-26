create database order_process;
use order_process;

create table Customer(cust int, cname varchar(30), city varchar(30), primary key(cust));
create table _Order(_order int, odate date, cust int, ord_amt int, primary key(_order, cust), foreign key(cust) references Customer(cust));
create table Item(item int, unit_price int, primary key(item));
create table Order_Item(_order int, item int, qty int, primary key(_order, item), foreign key(_order) references _Order(_order), foreign key(item) references Item(item));
create table Warehouse(warehouse int, city varchar(30), primary key(warehouse));
create table Shipment(_order int, warehouse int, ship_date date, primary key(_order, warehouse), foreign key(_order) references _Order(_order), foreign key(warehouse) references Warehouse(warehouse));

insert into Customer values(1, 'Sai Ganesh S', 'Ballari');
insert into Customer values(2, 'Rahul', 'Bengaluru');
insert into Customer values(3, 'Rohit', 'Mysuru');
insert into Customer values(4, 'John', 'Chennai');
insert into Customer values(5, 'Prateek', 'Delhi');

insert into _Order values(1, '2022-06-26', 2, 200);
insert into _Order values(2, '2021-12-13', 1, 1000);
insert into _Order values(3, '2022-03-04', 3, 500);
insert into _Order values(4, '2021-08-14', 5, 700);
insert into _Order values(5, '2022-06-11', 4, 1200);
insert into _Order values(6, '2022-07-13', 1, 500);

insert into Item values(1, 1000);
insert into Item values(2, 500);
insert into Item values(3, 500);
insert into Item values(4, 700);
insert into Item values(5, 1200);

insert into Order_Item values(1, 3, 1);
insert into Order_Item values(1, 4, 2);
insert into Order_Item values(2, 3, 1);
insert into Order_Item values(3, 3, 3);
insert into Order_Item values(5, 1, 2);

insert into Warehouse values(1, 'Bengaluru');
insert into Warehouse values(2, 'Mysuru');
insert into Warehouse values(3, 'Delhi');
insert into Warehouse values(4, 'Chennai');
insert into Warehouse values(5, 'Ballari');
insert into Warehouse values(6, 'Ballari');

insert into Shipment values(1, 2, '2022-06-12');
insert into Shipment values(2, 5, '2022-08-17');
insert into Shipment values(4, 4, '2022-02-05');
insert into Shipment values(5, 2, '2022-01-24');
insert into Shipment values(3, 1, '2022-06-16');

select c.cname, count(o._order), avg(o.ord_amt) from Customer c, _Order o where c.cust=o.cust group by o.cust;

select s._order from Shipment s, Warehouse w where s.warehouse=w.warehouse group by w.city
