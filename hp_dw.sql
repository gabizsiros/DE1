select * from characters;
select * from movies;
select * from chapters;
select * from dialogue;

select * from dialogue;
select Character_ID, sum(sent_score), Chapter_ID FROM dialogue GROUP BY Character_ID;

SELECT 
   *
FROM
    chapters
LEFT JOIN movies
    USING (Movie_ID);