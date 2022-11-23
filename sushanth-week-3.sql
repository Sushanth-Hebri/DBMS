create database bank1;
use bank1;


create table branch
(branch_name varchar(20),
branch_city varchar(20),
assets float(20),
primary key(branch_name)
);

create table bankaccount
(accno int(20),
branch_name varchar(20),
balance float(20),
primary key(accno),
foreign key(branch_name) references branch(branch_name));
select * from branch,bankaccount;


create table bankcustomer
(
customer_name varchar(20),
customer_street varchar(20),
customer_city varchar(20),
primary key(customer_name)
);

create table depositer
(customer_name varchar(20),
accno int(20),
primary key(customer_name,accno),
foreign key(customer_name) references bankcustomer(customer_name) on delete cascade,
foreign key(accno) references bankaccount(accno) on delete cascade);

create table loan
(loan_num int,
branch_name varchar(20),
amount float(20),
primary key(loan_num),
foreign key(branch_name) references branch(branch_name) on delete cascade);

insert into branch values('SBI_Chamrajpet','Bangalore','50000'),('SBI Residency blre','Bangalore','10000'),('SBI Shivaji Road','Bombay','20000'),('SBI _ParlimentDelhi','Dehli','10000'),('SBI_jtmmtr_Delhi','Delhi','20000');
insert into bankaccount values('1','SBI_Chamrajpet','2000'),('2','SBI Residency blre','5000'),('3','SBI Shivaji Road','6000'),('4','SBI _ParlimentDelhi','9000'),('5','SBI_jtmmtr_Delhi',8000);
insert into bankaccount values('6','SBI Shivaji Road','4000');
insert into bankcustomer values('Avinash','Bull_Temple_Road','Bangalore'),('Dinesh','Bannergatta_Road','Bangalore'),('Mohan','NationalCollege_Road','Bangalore'),('Nikil','Akbar_Road','Delhi'),('Ravi','Prithviraj Road','Delhi');

set foreign_key_checks=0;
set global foreign_key_checks=0;

insert into depositer values('Avinash',1),('Dinesh',2),('Nikil',4),('Ravi',5),
('Avinash',8),('Nikil',9),('Dinesh',10),('Nikil',11);

insert into loan values(1,'SBI_Chamarajpet',1000),(2,'SBI_ResidencyRoad',2000),(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParlimentRoad',4000),(5,'SBI_Jantarmantar',5000);

select * from branch; 
select * from bankaccount;
select * from bankcustomer;
select * from depositer;
select * from loan;

select branch_name,assets/100000 as assets_in_lakh
from branch;

select  distinct customer_name
from depositer d, bankaccount b
where b.accno=d.accno and branch_name='SBI_ResidencyRoad'
having count(customer_name)>=2;

insert into bankaccount values(12,'SBI_ResidencyRoad','6000');
select customer_name
from depositer
where accno=10;

create view loansum as
select branch_name,sum(amount)
from loan
group by branch_name;
select * from loansum;
