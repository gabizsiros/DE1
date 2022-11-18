DROP VIEW IF EXISTS Popular_places;
CREATE VIEW `Popular_places` AS
SELECT Place, count(Dialogue), Movie FROM dialogue_analyse GROUP BY Place order by count(Dialogue) desc;


DROP VIEW IF EXISTS Box_Office;
CREATE VIEW `Box_Office` AS
SELECT Movie_Title, Budget, Box_Office, Profit, Release_Year FROM movies  order by Profit desc;

DROP VIEW iF exists `Most_Positive_Characters`;
CREATE VIEW `Most_Positive_Characters` AS
Select CharacterName, avg(Sentiment) AS Sentiment, count(Dialogue) AS Number_of_Dialogues FROM dialogue_analyse
GROUP BY CharacterName HAVING count(Dialogue) > 50
Order BY Sentiment desc;

DROP VIEW iF exists `Most_Negative_Characters`;
CREATE VIEW `Most_Negative_Characters` AS
Select CharacterName, avg(Sentiment) AS Sentiment, count(Dialogue) AS Number_of_Dialogues FROM dialogue_analyse
GROUP BY CharacterName HAVING count(Dialogue) > 50
Order BY Sentiment asc;

DROP VIEW IF EXISTS `Top_talkers`;
CREATE VIEW `Top_talkers` AS
Select Character_Name, count(Dialogue), avg(sent_score),
 CASE 
        WHEN avg(sent_score) > 0
            THEN 'Positive'
        WHEN  avg(sent_score) = 0 
            THEN 'NEUTRAL'
        ELSE 
            'NEGATIVE'
    END
    AS sent_cat  
FROM dialogue
LEFT JOIN characters
USING (Character_ID)
GROUP BY Character_Name ORDER BY count(Dialogue) desc;


