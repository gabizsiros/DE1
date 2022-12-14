-- creating Schema for Harry Potter Movie Dialogue DB
DROP SCHEMA IF EXISTS `hp`;
CREATE SCHEMA  `hp`;
USE `hp`;

-- loading each database 
SHOW VARIABLES LIKE "secure_file_priv";
SHOW VARIABLES LIKE "local_infile";
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
Movie_ID INTEGER,
Movie_Title VARCHAR(255) NOT NULL,
Release_Year YEAR,
Runtime INTEGER,
Budget VARCHAR(255),
Box_Office VARCHAR(255),
PRIMARY KEY (Movie_ID));
LOAD DATA INFILE 'Movies.csv' 
INTO TABLE movies 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' ;

DROP TABLE IF EXISTS characters;
CREATE TABLE characters (
Character_ID INTEGER,
Character_Name VARCHAR(255),
Species VARCHAR(255),
Gender VARCHAR(255),
House VARCHAR(255),
Patronus VARCHAR(255),
Wand_Wood VARCHAR(255),
Wand_Core VARCHAR(255),
PRIMARY KEY (Character_ID));
LOAD DATA INFILE 'Characters.csv' 
INTO TABLE characters 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' ;

-- chapters databse has foreign key
DROP TABLE IF EXISTS chapters;
CREATE TABLE chapters (
Chapter_ID INTEGER,
Chapter_Name VARCHAR(255),
Movie_ID INTEGER,
Movie_Chapter INTEGER,
PRIMARY KEY (Chapter_ID),
CONSTRAINT `fk_chapters_movies` FOREIGN KEY (Movie_ID) 
REFERENCES movies(Movie_ID));
LOAD DATA INFILE 'Chapters.csv' 
INTO TABLE chapters 
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES ();

DROP TABLE IF EXISTS places;
CREATE TABLE places(
Place_ID INTEGER,
Place_Name VARCHAR(255),
Place_Category VARCHAR(255),
PRIMARY KEY (Place_ID ));
LOAD DATA INFILE 'Places.csv' 
INTO TABLE places
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES ();

DROP TABLE IF EXISTS spells;
CREATE TABLE spells(
Spell_ID INTEGER,
Incantation VARCHAR(255),
Spell_Name VARCHAR(255),
Effect VARCHAR(255),
Light VARCHAR(255),
PRIMARY KEY (Spell_ID ));
LOAD DATA INFILE 'Spells.csv' 
INTO TABLE spells
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES ();

-- loading final databse with essential foreign keys
	DROP TABLE IF EXISTS dialogue;
	CREATE TABLE dialogue(
	Dialogue_ID INTEGER,
	Chapter_ID INTEGER,
	Place_ID INTEGER,
	Character_ID INTEGER,
	Dialogue TEXT,
    sent_score FLOAT,
	sent_value VARCHAR(8),
	PRIMARY KEY (Dialogue_ID ),
    CONSTRAINT `fk_dialogue_chapters` FOREIGN KEY (Chapter_ID) 
    REFERENCES chapters(Chapter_ID),
    CONSTRAINT `fk_dialogue_places` FOREIGN KEY (Place_ID) 
    REFERENCES places(Place_ID),
    CONSTRAINT `fk_dialogue_characters` FOREIGN KEY (Character_ID) 
    REFERENCES characters(Character_ID));
	LOAD DATA INFILE 'Dialogues_sentiment.csv' 
	INTO TABLE dialogue
	FIELDS TERMINATED BY ',' 
	OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n' 
	IGNORE 1 LINES ();
