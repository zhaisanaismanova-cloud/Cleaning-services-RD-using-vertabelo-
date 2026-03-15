alter session set nls_date_format = 'YYYY-MM-DD';

BEGIN
FOR c IN ( SELECT table_name FROM user_tables)
LOOP
EXECUTE IMMEDIATE 'DROP TABLE ' || c.table_name || ' CASCADE CONSTRAINTS' ;
END LOOP;
END;
/
DROP SEQUENCE employees_seq;
DROP SEQUENCE clients_seq;
DROP SEQUENCE clean_serv_seq;
DROP SEQUENCE feedback_seq;
DROP SEQUENCE work_hour_seq;
DROP SEQUENCE emp_serv_seq;
DROP SEQUENCE serv_client_seq;
-- tables
-- Table: cleaning_services
CREATE TABLE cleaning_services (
    ID_services integer  NOT NULL,
    name_of_service varchar2(20)  NOT NULL,
    price number(6,2)  NOT NULL,
    CONSTRAINT cleaning_services_pk PRIMARY KEY (ID_services)
) ;

-- Table: clients
CREATE TABLE clients (
    ID_clients integer  NOT NULL,
    client_name varchar2(20)  NOT NULL,
    client_surname varchar2(30)  NOT NULL,
    phone_number number(30)  NOT NULL,
    CONSTRAINT clients_pk PRIMARY KEY (ID_clients)
) ;

-- Table: employee
CREATE TABLE employee (
    ID_employee integer  NOT NULL,
    name varchar2(20)  NOT NULL,
    surname varchar2(20)  NOT NULL,
    number_card number(30)  NOT NULL,
    ID_supervisor integer  NULL,
    CONSTRAINT employee_pk PRIMARY KEY (ID_employee)
) ;

-- Table: employees_in_service
CREATE TABLE employee_in_service (
    ID_employee_in_service integer  NOT NULL,
    ID_cleaning_services integer  NOT NULL,
    ID_employee integer  NOT NULL,
    CONSTRAINT employees_in_service_pk PRIMARY KEY (ID_employee_in_service)
) ;

-- Table: feedbacks
CREATE TABLE feedbacks (
    ID_feedbacks integer  NOT NULL,
    date_of_sent timestamp  NOT NULL,
    "comment" varchar2(200)  NOT NULL,
    ID_type integer  NOT NULL,
    ID_clients integer  NOT NULL,
    CONSTRAINT feedbacks_pk PRIMARY KEY (ID_feedbacks)
) ;

-- Table: service_assigned_to_clients
CREATE TABLE service_assigned_to_clients (
    ID_service_client integer  NOT NULL,
    ID_clients integer  NOT NULL,
    ID_cleaning_services integer  NOT NULL,
    CONSTRAINT service_assigned_to_clients_pk PRIMARY KEY (ID_service_client)
) ;

-- Table: type
CREATE TABLE type (
    ID_type integer  NOT NULL,
    type_name varchar2(20)  NOT NULL,
    CONSTRAINT type_pk PRIMARY KEY (ID_type)
) ;

-- Table: working_days
CREATE TABLE working_days (
    ID_working_days integer  NOT NULL,
    days varchar2(200)  NOT NULL,
    CONSTRAINT working_days_pk PRIMARY KEY (ID_working_days)
) ;

-- Table: working_hours
CREATE TABLE working_hours (
    ID_working_hours integer  NOT NULL,
    startTime timestamp  NOT NULL,
    endTime timestamp  NOT NULL,
    ID_employees integer  NOT NULL,
    ID_working_days integer  NOT NULL,
    CONSTRAINT working_hours_pk PRIMARY KEY (ID_working_hours)
) ;


-- foreign keys
-- Reference: clients_cleaning_services (table: service_assigned_to_clients)
ALTER TABLE service_assigned_to_clients ADD CONSTRAINT clients_cleaning_services
    FOREIGN KEY (ID_cleaning_services)
    REFERENCES cleaning_services (ID_services);

-- Reference: employees_cleaning_services (table: employees_in_service)
ALTER TABLE employees_in_service ADD CONSTRAINT employees_cleaning_services
    FOREIGN KEY (ID_cleaning_services)
    REFERENCES cleaning_services (ID_services);

-- Reference: employees_employees (table: employees)
ALTER TABLE employees ADD CONSTRAINT employees_employees
    FOREIGN KEY (ID_supervisor)
    REFERENCES employees (ID_employees);

-- Reference: employees_in_service_employees (table: employees_in_service)
ALTER TABLE employees_in_service ADD CONSTRAINT employees_in_service_employees
    FOREIGN KEY (ID_employees)
    REFERENCES employees (ID_employees);

-- Reference: feedbacks_clients (table: feedbacks)
ALTER TABLE feedbacks ADD CONSTRAINT feedbacks_clients
    FOREIGN KEY (ID_clients)
    REFERENCES clients (ID_clients);

-- Reference: feedbacks_type (table: feedbacks)
ALTER TABLE feedbacks ADD CONSTRAINT feedbacks_type
    FOREIGN KEY (ID_type)
    REFERENCES type (ID_type);

-- Reference: service_to_clients (table: service_assigned_to_clients)
ALTER TABLE service_assigned_to_clients ADD CONSTRAINT service_to_clients
    FOREIGN KEY (ID_clients)
    REFERENCES clients (ID_clients);

-- Reference: working_hours_days (table: working_hours)
ALTER TABLE working_hours ADD CONSTRAINT working_hours_days
    FOREIGN KEY (ID_working_days)
    REFERENCES working_days (ID_working_days);

-- Reference: working_hours_employees (table: working_hours)
ALTER TABLE working_hours ADD CONSTRAINT working_hours_employees
    FOREIGN KEY (ID_employees)
    REFERENCES employees (ID_employees);

-- End of file.
--employees
select * from employee;
create sequence employees_seq
start with 1
increment by 1;

insert into employee(ID_employee,name,surname,number_card)
values (employees_seq.nextval, 'Zhaisana','Ismanova', '123'); 
insert into employee (ID_employee,name,surname,number_card)
values (employees_seq.nextval, 'Aibek','Sabitbekov', '4567'); 
insert into employee (ID_employee,name,surname,number_card)
values (employees_seq.nextval, 'Daniel','Bekmuratov', '789'); 
insert into employee (ID_employee,name,surname,number_card)
values (employees_seq.nextval, 'Yurii','Zhirkov', '101'); 
insert into employee (ID_employee,name,surname,number_card)
values (employees_seq.nextval, 'Mateusz','Nowak', '1102'); 
insert into employee (ID_employee,name,surname,number_card)
values (employees_seq.nextval, 'Azamat','Medetov', '131'); 
insert into employee (ID_employee,name,surname,number_card)
values (employees_seq.nextval, 'Nurdoolot','Nurseiitov', '415');
--clients
select * from clients;

create sequence clients_seq
start with 1
increment by 1;

insert into clients (ID_clients,client_name,client_surname,phone_number)
 values(clients_seq.nextval,'Christos','Voskres','455891');
insert into clients (ID_clients,client_name,client_surname,phone_number)
values(clients_seq.nextval,'Roman','Svetly','3790675');
insert into clients (ID_clients,client_name,client_surname,phone_number)
values (clients_seq.nextval,'Isabek','Mamaev','74355023');
insert into clients (ID_clients,client_name,client_surname,phone_number)
values(clients_seq.nextval,'Ali','Mcgregor','82074321');
--cleaning services

select * from cleaning_services;
create sequence clean_serv_seq
start with 1
increment by 1;

 insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'washing car', 50);
insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'cleaning dishes','35');
insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'cleaning house' ,'100');
 insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'laundry' ,'150');
insert into cleaning_services (ID_services,name_of_service,price)
 values(clean_serv_seq.nextval,'all inclusive', '485');
 --emp in services
 select * from employee_in_service;
 create sequence emp_serv_seq
start with 1
increment by 1;
insert into employee_in_service(ID_employee_in_service,ID_employee,ID_cleaning_services)
values(emp_serv_seq.nextval,3,21);
insert into employee_in_service(ID_employee_in_service,ID_employee,ID_cleaning_services)
values(emp_serv_seq.nextval,3,22);
insert into employee_in_service(ID_employee_in_service,ID_employee,ID_cleaning_services)
values(emp_serv_seq.nextval,2,21);
insert into employee_in_service(ID_employee_in_service,ID_employee,ID_cleaning_services)
values(emp_serv_seq.nextval,5,21);
--type 
select * from type;
insert into type(ID_type,type_name)
 values(1,'gratitude');
 insert into type(ID_type,type_name)
 values(2,'complaints');
 insert into type(ID_type,type_name)
 values(3,'suggestions');
 --feedbacks 

 select * from feedbacks;
 create sequence feedback_seq
start with 1
increment by 1;

insert into feedbacks(ID_feedbacks,date_of_sent, "comment", ID_type,ID_clients)
values(feedback_seq.nextval,To_Date('2020-03-15', 'yyyy-mm-dd'), 'Thanks a lot',1,1);
insert into feedbacks(ID_feedbacks,date_of_sent, "comment", ID_type,ID_clients)
values(feedback_seq.nextval,To_date('2021-09-07','yyyy-mm-dd'), 'Didnt like at all',2,3);
insert into feedbacks(ID_feedbacks,date_of_sent, "comment", ID_type,ID_clients)
values(feedback_seq.nextval,To_date('2020-12-25','yyyy-mm-dd'), 'Needs improvements in washing a car',3,4);
--working days
select * from working_days;
insert into working_days(ID_working_days, days)
values(1,'Monday');
insert into working_days(ID_working_days, days)
values(2,'Wednesday');
insert into working_days(ID_working_days, days)
values(3,'Friday');
insert into working_days(ID_working_days, days)
values(4,'Saturday');
--working hours 
select * from working_hours;
create sequence work_hour_seq
start with 1
increment by 1;


insert into working_hours(ID_working_hours,startTime,endTime,ID_employee,ID_working_days)
values(work_hour_seq.nextval,to_timestamp('2020-11-13 9:10:00.742000000','yyyy-mm-dd hh24:mi:ss.ff'),to_timestamp('2020-11-13 18:00:00.742000000','yyyy-mm-dd hh24:mi:ss.ff'),3,1);
insert into working_hours(ID_working_hours,startTime,endTime,ID_employee,ID_working_days)
values(work_hour_seq.nextval,to_timestamp('2020-11-14 8:30:00.742000000','yyyy-mm-dd hh24:mi:ss.ff'),to_timestamp('2020-11-14 17:15:00.742000000','yyyy-mm-dd hh24:mi:ss.ff'),4,2);
insert into working_hours(ID_working_hours,startTime,endTime,ID_employee,ID_working_days)
values(work_hour_seq.nextval,to_timestamp('2020-11-15 7:40:00.742000000','yyyy-mm-dd hh24:mi:ss.ff'),to_timestamp('2020-11-15 14:00:00.742000000','yyyy-mm-dd hh24:mi:ss.ff'),1,3);
insert into working_hours(ID_working_hours,startTime,endTime,ID_employee,ID_working_days)
values(work_hour_seq.nextval,to_timestamp('2020-11-18 10:20:00.742000000','yyyy-mm-dd hh24:mi:ss.ff'),to_timestamp('2020-11-18 19:00:00.742000000','yyyy-mm-dd hh24:mi:ss.ff'),7,4);
--service_assign
select * from service_assigned_to_clients;
create sequence serv_client_seq
start with 1
increment by 1;
insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,2,22);
insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,3,25);
insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,4,23);
insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,1,24);
insert into service_assigned_to_clients(ID_service_client,ID_clients,ID_cleaning_services)
values(serv_client_seq.nextval,3,21);
--1, 1 SELECT statements that joins at least two tables and contains WHERE clause
select e.name, s.ID_employee
from employee e,employee_in_service s
where s.ID_employee=e.ID_employee;
--2 1 SELECT statements that joins at least two tables and contains GROUP BY and HAVING clauses
select client_name, count(feedbacks.ID_feedbacks) as nummberofFeedbacks
from feedbacks 
inner join clients on feedbacks.ID_clients=clients.ID_clients
group by client_name
having count(feedbacks.ID_feedbacks)=1;
--3 1 SELECT statement with subquery
Select name_of_service from cleaning_services
where ID_services in (select ID_cleaning_services from employee_in_service where ID_employee=5);

--4 1 SELECT statement with correlated subquery
select s.ID_clients,s.ID_cleaning_services
from service_assigned_to_clients s
where  s.ID_clients=(
select c.ID_clients from clients c
where c.ID_clients=1);

