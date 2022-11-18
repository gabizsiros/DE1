--  Transforming 'movies' table's text variables, calculating 'Profit' column
ALTER TABLE movies
ADD Profit INTEGER
GENERATED ALWAYS AS
 (
 CAST(replace(right(Box_Office,LENGTH(Box_Office)-1),",","") AS DOUBLE) - 
 CAST(REPLACE(Right(Budget,LENGTH(Budget)-1),",","") AS DOUBLE)
 ) STORED;


-- !creating DW
DROP TABLE IF EXISTS dialogue_analyse;

	CREATE TABLE dialogue_analyse AS
	SELECT 
	   characters.Character_Name AS CharacterName, 
	   dialogue.Dialogue AS Dialogue, 
	   chapters.Chapter_Name AS Chapter,
	   movies.Movie_Title AS Movie,
	   dialogue.sent_score As Sentiment,
       places.Place_Name AS Place
       FROM
		dialogue
        LEFT JOIN chapters
		USING (Chapter_ID)
		LEFT JOIN movies
		USING(Movie_ID)
		LEFT JOIN characters
		USING (Character_ID)
		LEFT JOIN places
		USING(Place_ID);
  

    

    