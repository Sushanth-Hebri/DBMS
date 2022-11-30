create database Bankdata;
use Bankdata;

create table branch(
branch_name varchar(30) primary key,
branch_city varchar(20),
assets real);

create table bank_account(
acc_no int primary key,
branch_name varchar(30),
balance real,
foreign key(branch_name) references branch(branch_name) on delete cascade);

create table bank_customer(
customer_name varchar(30) primary key,
customer_street varchar(30),
customer_city varchar(30));


create table depositer(
customer_name varchar(30),
acc_no int,
foreign key(customer_name) references bank_customer(customer_name) on delete cascade,
foreign key(acc_no) references bank_account(acc_no) on delete cascade);

create table loan(
loan_number int primary key,
branch_name varchar(30),
amount real,
foreign key(branch_name) references branch(branch_name) on delete cascade);

create table Borrower(
loan_number int,
customer_name varchar(30),
foreign key(customer_name) references bank_customer(customer_name) on delete cascade,
foreign key(loan_number) references loan(loan_number) on delete cascade);

insert into branch values('SBI_Chamrajpet','Bangalore',5000),('SBI_ResidencyRoad','Bangalore',1000),('SBI_ShivajiRoad','Bombay',20000),('SBI_ParliamentRoad','Delhi',10000),('SBI_JantarMantar','Delhi',20000);
insert into bank_account values(1,'SBI_ResidencyRoad',2000),(2,'SBI_ResidencyRoad',5000),(3,'SBI_ShivajiRoad',6000),(4,'SBI_ParliamentRoad',9000),(5,'SBI_JantarMantar',8000);

set foreign_key_checks=0;
set global foreign_key_checks=0;

insert into bank_customer values('Avinash','Bull_Temple_Road','Bangalore'),('Dinesh','Bannergatta_Road','Bangalore'),('Mohan','NationalCollege_Road','Bangalore'),('Nikil','Akbar_Road','Delhi'),('Ravi','Prithviraj_Road','Delhi');
insert into depositer values('Dinesh',1),('Dinesh',2),('Mohan',3),('Nikil',4),('Ravi',5);
insert into loan values(1,'SBI_Chamrajpet',1000),(2,'SBI_ResidencyRoad',2000),(3,'SBI_ShivajiRoad',3000),(5,'SBI_JantarMantar',5000);

select d.customer_name 
from bank_account a,branch b,depositer d
where b.branch_name=a.branch_name and a.acc_no=d.acc_no and b.branch_city='Delhi'
group by d.customer_name
having count(distinct b.branch_name)=
(select count(branch_name)
from branch
where branch_city='Delhi');


insert into Borrower values(1,'Dinesh'),(2,'Dinesh'),(3,'Mohan'),(4,'Nikil'),(5,'Ravi');

select distinct b.customer_name from Borrower b, Depositer d
where b.customer_name NOT IN
(select d.customer_name from loan l,depositer d, Borrower b
where l.loan_number=b.loan_number and d.customer_name=b.customer_name);

select b.branch_name from branch b
where b.assets > ALL (
select sum(b.assets) from Branch b
where b.Branch_City='Bangalore');


select distinct d.customer_name from depositer d
where d.customer_name in(
select d.customer_name from branch br,depositer d, bank_account ba
where br.Branch_city='Bangalore' and br.Branch_name=ba.Branch_name and ba.acc_no=d.acc_no and customer_name in
(select customer_name from Borrower)); 


select * from branch;

update bank_account
set balance = balance*1.05;
select balance from bank_account; 

delete from bank_account 
where branch_name in
(select branch_name from branch 
where branch_city='Bombay');
select * from bank_account; 

select * from bank_customer;