create database employee2;
use employee2;


-- 1.department table
create table dept
(dname varchar(30),
deptno varchar(10) primary key,
dloc varchar(30));

-- 2.project table
create table project
(pno int(4) primary key,
ploc varchar(30),
pname varchar(20));

-- 3.employees table
create table emloyees
(empno varchar(20) primary key,
ename varchar(20),
mgrno varchar(20),
hiredate date,
sal int(10),
deptno varchar(30),
foreign key(deptno) references dept(deptno) on delete cascade);

 -- 4.assigned to table
create table assigned
(empno varchar(20),
pno int(4),
jobrole varchar(30),
foreign key(empno) references employees(empno) on delete cascade,
foreign key(pno) references project(pno) on delete cascade);

-- 5.incentives table
create table incentives
(empno varchar(20),
incentive_date date primary key,
incentive_amount int(10),
foreign key(empno) references employees(empno) on delete cascade);
select * from dept;


-- inserting values to tables , .
insert into dept values('Human_Resource','1','bangalore'),('IT','2','hyderbad'),('Finance','3','mysore'),('Operations_management','4','hasana'),('Marketing','5','udupi'),('Research','6','mangalore');
insert into project values('11','bangalore','abc'),('12','delhi','def'),('13','hyderbad','ghi'),('14','udupi','jkl'),('15','mangalore','mno'),('16','mumbai','pqr');
insert into emloyees values('e1','subhash','m1','2010-01-11','5000','1'),('e2','sukumar','m1','2013-05-03','10000','2'),
                            ('e3','vijay','m2','2014-03-13','3000','3'),('e4','elon','m2','2015-03-02','6000','4'),('e5','harry','m3','2013-07-20','5000','5')
                            ,('e6','sudeep','m4','2020-02-02','8900','6');
                            insert into emloyees values('e7','mohan','m4','2020-01-01','2000',2),('e8','sam','m3','2009-02-03','4000','2');
insert into assigned values('e1','01','controller'),('e2','02','technician'),('e3','03','ca'),('e4','04','supervisor'),('e5','05','advertizer'),('e6','06','scientist');
insert into assigned values('e7','11','utilizer'),('e8','13','mainperson');
insert into incentives values('e1','2022-01-18','3000'),('e2','2021-01-01','2300'),('e3','2022-01-10','3400');
insert into incentives values('e4','2014-09-09','0');
show tables;

-- to do
-- 1.Retrieve the employee numbers of all employees who work on project located in Bengaluru, Hyderabad, or Mysuru
select a.empno
from assigned a
where a.pno in (select a.pno
from project p, assigned a 
  where p.pno=a.pno
and   p.ploc in('bangalore','hyderbad','mysore'));


-- 2.Get Employee ID’s of those employees who didn’t receive incentives
select e.empno
from emloyees e left outer join incentives i
on e.empno=i.empno where i.empno is null or i.incentive_amount=0;

-- 3.Write a SQL query to find the employees name, number, dept,job_role, department location and project location who are working for
-- a project location same as his/her department location.

select e.ename,e.empno,e.deptno department_number,a.jobrole,p.ploc,d.dloc
from emloyees e,assigned a,project p,dept d
where p.ploc in(select p.ploc
from  emloyees e,assigned a,project p,dept d
where p.ploc=d.dloc and d.deptno=e.deptno);

