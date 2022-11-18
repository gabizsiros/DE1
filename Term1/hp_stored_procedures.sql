
-- creating a materialized view with the input of movie number (Movie_ID)
DROP PROCEDURE IF EXISTS GetMovieSummary;
DELIMITER //
CREATE PROCEDURE GetMovieSummary( x INT)
BEGIN

	DROP TABLE IF EXISTS movie_summary;

	CREATE TABLE movie_summary AS
	SELECT
		movies.Movie_Title AS Movie,
		count(distinct(characters.Character_Name)) AS Characters, 
		count(distinct(dialogue.Dialogue)) AS Dialogues, 
		count(distinct(chapters.Chapter_Name)) AS Chapters,
		concat('$ ',movies.Profit) AS Profit,
		avg(dialogue.sent_score) As Average_Sentiment
		FROM dialogue
			LEFT JOIN chapters
			USING (Chapter_ID)
			LEFT JOIN movies
			USING(Movie_ID)
			LEFT JOIN characters
			USING (Character_ID)
			LEFT JOIN places
			USING (Place_ID)
		WHERE x = Movie_ID;
        SELECT * FROM movie_summary;
        END //
DELIMITER ;

Call GetMovieSummary(3);


-- dynamic procedure to extract detailed scripts with the input of movie number (Movie_ID)

DROP PROCEDURE IF EXISTS GetMovieScript;
DELIMITER //
CREATE PROCEDURE GetMovieScript( x INT)
BEGIN

	DROP TABLE IF EXISTS movie_script;

	CREATE TABLE movie_script AS
	SELECT 
	   characters.Character_Name AS CharacterName, 
	   dialogue.Dialogue AS Dialogue, 
       places.Place_Name AS Location,
	   chapters.Chapter_Name AS Chapter,
	   dialogue.sent_score As Sentiment
      FROM dialogue
			LEFT JOIN chapters
			USING (Chapter_ID)
			LEFT JOIN movies
			USING(Movie_ID)
			LEFT JOIN characters
			USING (Character_ID)
			LEFT JOIN places
			USING (Place_ID)
		WHERE x = Movie_ID;
        select * from movie_data;
        END //
DELIMITER ;

Call GetMovieScript(5);

