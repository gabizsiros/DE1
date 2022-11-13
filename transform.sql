DROP TABLE IF EXISTS movies2;
CREATE TABLE movies2 (
Movie_ID INTEGER,
Movie_Title VARCHAR(255) NOT NULL,
Release_Year YEAR,
Runtime INTEGER,
Budget VARCHAR(255),
Box_Office VARCHAR(255),
PRIMARY KEY (Movie_Title));
LOAD DATA INFILE 'Movies.csv' 
INTO TABLE movies2 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' ;

Select Movie_Title, Budget, Box_Office FROM movies2;
select Movie_Title, cast(right(Budget,LENGth(Budget)-1) as DOUBLE)*100000, right(replace(Box_Office,",",""),length(Box_Office)-1) FROM movies2;
select Movie_Title, cast(right(Budget,LENGth(Budget)-1) as DOUBLE)*100000 AS BUDGET, 
cast(replace(right(Box_Office,length(Box_Office)-1),",","") as double) as BOX_OFFICE,
BOX_OFFICE - BUDGET FROM movies2;
INSERT INTO movies2 select cast(right(Budget,LENGth(Budget)-1) as DOUBLE)*100000 from movies2;