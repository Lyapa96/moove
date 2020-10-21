
-- выделяем отдельную таблицу для связи 1 ко многим
create table phones
(
    employee_id int,
    phone varchar(50)
);

-- по-хорошему нужно выделять в отдельные таблицы department и postion, чтобы уменьшить размер базы
create table employees (
	id SERIAL  PRIMARY KEY,
	last_name varchar(255),
	first_name varchar(255),
	email varchar(255),
	room int,
	department varchar(50),
	position varchar(50)
);

create index department_idx on employees using hash(department);
create index position_idx on employees using hash(position);

----

-- 1) получение всех имен и фамилий людей в определенном кабинете; 

select first_name, last_name from employees where room = 5424;

-- 2) добавление нового телефона сотруднику;

-- id = (select id from employees where first_name = 'William' and last_name = 'Anderson')
insert into phones (employee_id, phone) values (1, '+75649310937');

-- 3) получение списка телефонов всех сотрудников определенной должности в одном из отделов; 

select phone from phones 
where employee_id in (select id from employees where department = 'Clerical Office' and position = 'Specialist');

-- 4) добавление нового сотрудника;

insert into employees (department, email, first_name, last_name, position,	room) values ('Clerical Office',	'William_Anderson@example.com',	'William', 'Anderson', 'Specialist'	, 5424);

-- 5) перемещение сотрудника в другой отдел со сменой комнаты.

update employees
SET department = 'new department', room = 42
where id = 1;
