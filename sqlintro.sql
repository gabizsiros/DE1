create schema firstdb;
use firstdb;
drop schema firstdb;
drop schema if exists firstdb;
CREATE SCHEMA firstdb;
USE firstdb;
drop schema firstdb;
create schema birdstrikes;
use birdstrikes;
CREATE TABLE birdstrikes
(id INTEGER NOT NULL,
aircraft VARCHAR(32),
flight_date DATE NOT NULL,
damage VARCHAR(16) NOT NULL,
airline VARCHAR(255) NOT NULL,
state VARCHAR(255),
phase_of_flight VARCHAR(32),
reported_date DATE,
bird_size VARCHAR(16),
cost INTEGER NOT NULL,
speed INTEGER,
PRIMARY KEY(id));

select * from birdstrikes;
show tables;
describe birdstrikes;
SELECT airline,cost FROM birdstrikes;
select cost from birdstrikes;
SHOW VARIABLES LIKE "secure_file_priv";
SHOW VARIABLES LIKE "local_infile";
LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/birdstrikes_small.csv' 
INTO TABLE birdstrikes 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(id, aircraft, flight_date, damage, airline, state, phase_of_flight, @v_reported_date, bird_size, cost, @v_speed)
SET
reported_date = nullif(@v_reported_date, ''),
speed = nullif(@v_speed, '');


CREATE TABLE new_birdstrikes LIKE birdstrikes;
SHOW TABLES;
DESCRIBE new_birdstrikes;
SELECT * FROM new_birdstrikes;
drop table if exists new_birdstrikes;
create table employee
(id INTEGER NOT NULL,
employee_name VARCHAR(255) NOT NULL,
PRIMARY KEY(id));
select * FROM employee;
drop table employee;
INSERT INTO employee (id,employee_name) VALUES(1,'Student1');
INSERT INTO employee (id,employee_name) VALUES(2,'Student2');
INSERT INTO employee (id,employee_name) VALUES(3,'Student3');
INSERT INTO employee (id,employee_name) VALUES(4,'Student4');
UPDATE employee SET employee_name='Arnold Schwarzenegger' WHERE id = '1';
UPDATE employee SET employee_name='The Other Arnold' WHERE id = '2';
DELETE FROM employee WHERE id = 3;
TRUNCATE employee;
CREATE USER 'gabizsiros'@'%' IDENTIFIED BY 'gabizsiros1';
GRANT ALL ON birdstrikes.employee TO 'gabizsiros'@'%';
GRANT SELECT (state) ON birdstrikes.birdstrikes TO 'gabizsiros'@'%';
drop user 'gabizsiros'@'%';

use birdstrikes;
select *, speed/2 as halfspeed FROM birdstrikes limit 144,1;
SELECT state, cost FROM birdstrikes ORDER BY cost;
SELECT state, cost FROM birdstrikes ORDER BY state ASC, cost DESC;
select flight_date,id FROM birdstrikes order by id DESC Limit 1;
SELECT DISTINCT state FROM birdstrikes order by state asc;
SELECT DISTINCT airline, damage FROM birdstrikes order by airline;
select distinct cost from birdstrikes order by cost desc limit 49,1;
SELECT * FROM birdstrikes WHERE state LIKE 'A%';
SELECT DISTINCT state FROM birdstrikes WHERE state LIKE 'ala%';
SELECT DISTINCT state FROM birdstrikes WHERE state NOT LIKE 'a%' ORDER BY state;
SELECT * FROM birdstrikes WHERE state = 'Alabama' OR bird_size = 'Small';
SELECT DISTINCT state FROM birdstrikes WHERE state != '' ORDER BY state;
SELECT * FROM birdstrikes WHERE state IN ('Alabama', 'Missouri','New York','Alaska');
SELECT DISTINCT(state) FROM birdstrikes WHERE LENGTH(state) < 5;

