-- 0. (Having a glimpse of imported data)
select * from characters;
select * from movies;
select * from chapters;
select * from dialogue;



-- 1. dummy table for alter table experiment

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


-- 2. alter column experiment

Select Movie_Title, Budget, Box_Office FROM movies2;
select Movie_Title, cast(right(Budget,LENGth(Budget)-1) as DOUBLE)*100000 AS BUDGET, 
cast(replace(right(Box_Office,length(Box_Office)-1),",","") as double) as BOX_OFFICE FROM movies2;

select Movie_Title, cast(replace(right(Box_Office,length(Box_Office)-1),",","") as double) - cast(right(Budget,LENGth(Budget)-1) as DOUBLE)*100000 AS PROFIT FROM movies2;

INSERT INTO movies2 VALUES cast(replace(right(Box_Office,length(Box_Office)-1),",","") as double) - cast(right(Budget,LENGth(Budget)-1) as DOUBLE)*100000  AS PROFIT from movies2;

-- 3. alter table experiment
ALTER TABLE movies2
ADD Profit INTEGER
GENERATED ALWAYS AS
 (
 cast(replace(right(Box_Office,length(Box_Office)-1),",","") as double) - 
 CAST(REPLACE(Right(Budget,LENGTH(Budget)-1),",","") AS DOUBLE)
 ) STORED;

select * from movies2;

INSERT INTO movies2 (budget2) VALUES (cast(right(Budget,LENGth(Budget)-1) as DOUBLE));

-- 4. JOINS

--  (joining chapters and movies)
SELECT *
FROM chapters
LEFT JOIN movies
    USING (Movie_ID);
    
  -- (joining  dialogues with chapters and movies)
SELECT * FROM dialogue
LEFT JOIN chapters
	USING (Chapter_ID)
    left join movies
    USING(Movie_ID)
    left join characters
    USING (Character_ID);


-- 5. VIEWS
-- 5.1. Profit view
Select * FROM movies 
RIGHT JOIN chapters
USING (Movie_ID)
RIGHT JOIN dialogue
USING (Chapter_ID)
group by Movie_Title
Order BY Profit;


-- (5.2. sentiment per character)
select * from dialogue;
select Character_ID, sum(sent_score), Chapter_ID FROM dialogue GROUP BY Character_ID;

-- (5.3.1sentiment per character -draft)
Select Character_Name, avg(sent_score) AS Sentiment FROM dialogue
LEFT JOIN characters
USING (Character_ID)
GROUP BY Character_Name
Order BY Sentiment desc;

-- 5.3.2 sentiment per character (avg vs sum)
Select CharacterName, avg(Sentiment) AS Sentiment, sum(Sentiment) AS Sentiment2, count(Dialogue) AS Dialogues FROM dialogue_analyse
GROUP BY CharacterName HAVING count(Dialogue) > 50
Order BY Sentiment desc;

-- 5.3.3 deviding about sum or avg sentiment
Select CharacterName, avg(Sentiment), sum(Sentiment) / count(Dialogue) FROM dialogue_analyse
GROUP BY CharacterName;

-- 5.3.4 sentiment per character + dialogues
Select Character_Name, count(Dialogue), avg(sent_score) FROM dialogue
LEFT JOIN characters
USING (Character_ID)
GROUP BY Character_Name ORDER BY count(Dialogue) desc;

-- Select movie, character, most dialogue, place wiht most dialogue (avg sentitment)
-- dialgoues / sentiment
Select Movie, count(Dialogue), avg(Sentiment), Box_Office FROM dialogue_analyse 
left join movies
ON movies.Movie_Title=dialogue_analyse.Movie
group by Movie
ORDER BY Movie_ID asc;

-- experiment most places mentioned per movie
SELECT Movie, Place, count(Place) FROM dialogue_analyse group by Place order by movies.Movie_ID (Place);

  -- sentiment per movie              
	select Movie, sum(Sentiment), count(dialogue) from dialogue_analyse group by Movie;
    
    SELECT CharacterName,  (Dialogue) from dialogue_analyse group by CharacterName order by count(Dialogue) desc;
    
