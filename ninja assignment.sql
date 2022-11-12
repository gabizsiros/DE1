create schema ninjadb;
create table ninja
(id VARCHAR(255),
person VARCHAR(255),
department VARCHAR(255),
salary integer);
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ninja.txt' 
INTO TABLE ninja
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES starting by 'Data:' terminated by '\n'
IGNORE 2 LINES
(id, person, department, @v_salary)
SET
salary = @v_salary/1000;
select * from ninja;

