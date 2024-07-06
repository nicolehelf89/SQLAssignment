/** 
Final Group Project Part 1 - MS SQL
BDAT1010-24S-30691

Movie Database

Nicole Helf
Anushiya Pitchai Nadar
Fizaben Vahora

Due: July 17, 2024
**/

--Switch to master Database
USE [master]
GO

--Check to see if the database exists and drop it if it does
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'Movies')
BEGIN
	-- Drop the database
	DROP DATABASE Movies;
END
GO

-- Create a database "Movies"
CREATE DATABASE Movies;
GO

--Switch to Movie Database
USE [Movies]
GO

-- Create a "mov" schema under "Movies"
CREATE SCHEMA mov;
GO

--DROP tables prior to creating them to start from scratch
DROP TABLE IF EXISTS mov.Movie_Director;
DROP TABLE IF EXISTS mov.Movies;
DROP TABLE IF EXISTS mov.Movie_Actor;
DROP TABLE IF EXISTS mov.Movie_Rating;

--Create the Movie_Director table with constraints and specifications
CREATE TABLE mov.Movie_Director(
	Director_ID	int NOT NULL IDENTITY(100,10) Constraint PK_Director_ID PRIMARY KEY CLUSTERED,
	Director_First_Name varchar(50),
	Director_Last_Name varchar(50),
	Director_Age_in_Years int,
	Director_Gender varchar(10),
	CreatedOn date NOT NULL Constraint DF_CreatedOn DEFAULT GETDATE()
);
GO

--insert values into Movie_Director table. Did not add Director_ID or CreatedOn values as they are auto generated from constraints.
INSERT INTO mov.Movie_Director (Director_First_Name, Director_Last_Name, Director_Age_in_Years, Director_Gender)
VALUES 
    ('Kevin', 'Smith', 52, 'Male'),
    ('Miguel', 'Arteta', 41, 'Male'),
    ('Mark', 'Johnson', 58, 'Male'),
    ('Tom', 'Vaughan', 37, 'Male'),
    ('Francis', 'Lawrence', 52, 'Male'),
    ('Adrienne', 'Shelly', 40, 'Female'),
    ('David', 'Slade', 53, 'Male'),
    ('Mark', 'Palansky', 53, 'Male'),
    ('Jeff', 'Lowell', 49, 'Male'),
    ('Simon', 'Curtis', 37, 'Male'),
    ('Marc', 'Lawrence', 95, 'Male'),
    ('Anand', 'Tucker', 59, 'Male'),
    ('Judd', 'Apatow', 55, 'Male'),
    ('Cary', 'Fukunaga', 45, 'Male'),
    ('Mark', 'Helfrich', 49, 'Male'),
    ('Nanette', 'Burstein', 52, 'Female'),
    ('James', 'McAvoy', 44, 'Male'),
    ('Mark', 'Waters', 58, 'Male'),
    ('Seth', 'Gordon', 46, 'Male'),
    ('Alex', 'Kendrick', 52, 'Male'),
    ('Kevin', 'Lima', 60, 'Male'),
    ('Lasse', 'Hallström', 76, 'Male'),
    ('Ewan', 'McGregor', 52, 'Male'),
    ('Rajkumar', 'Hirani', 60, 'Male'),
    ('Ashutosh', 'Gowariker', 59, 'Male'),
    ('Karan', 'Johar', 50, 'Male'),
    ('S.S', 'Rajamouli', 49, 'Male'),
    ('Sukumar', NULL, 53, 'Male'),
    ('Aditya', 'Chopra', 51, 'Male'),
    ('Umesh', 'Shukla', 52, 'Male');
GO

--Create the Movies table with constraints and specifications
CREATE TABLE mov.Movies (
    Movie_ID int NOT NULL IDENTITY(1000,1) Constraint PK_Movie_ID PRIMARY KEY CLUSTERED,
    Movie_Name VARCHAR(255),
    Movie_Released_Year INT,
    Movie_Lead_Studio VARCHAR(255),
    Movie_Language VARCHAR(255),
    Movie_Category VARCHAR(255),
    Movie_Duration_in_Min INT,
    Movie_Worldwide_Earning_in_$M DECIMAL(15,2),
    Movie_Type VARCHAR(20) CONSTRAINT CK_Movie_Type CHECK (Movie_Type IN('Hollywood', 'Bollywood')),
    Director_ID INT CONSTRAINT FK_Director_ID FOREIGN KEY REFERENCES mov.Movie_Director(Director_ID),
    CreatedOn date NOT NULL Constraint DF_CreatedOn_Movies DEFAULT GETDATE()
);
GO

--insert values into Movie table. Did not add Movie_ID or CreatedOn values as they are auto generated from constraints.
INSERT INTO mov.Movies(
    Movie_Name,
    Movie_Released_Year,
    Movie_Lead_Studio,
    Movie_Language,
    Movie_Category,
    Movie_Duration_in_Min,
    Movie_Worldwide_Earning_in_$M,
    Movie_Type,
    Director_ID
)
VALUES
('Zack and Miri Make a Porno', 2008, 'The Weinstein Company', 'English', 'Romance', 101, 41.94, 'Hollywood', 100),
('Youth in Revolt', 2010, 'The Weinstein Company', 'English', 'Comedy', 90, 19.62, 'Hollywood', 110),
('When in Rome', 2010, 'Disney', 'English', 'Comedy', 91, 43.04, 'Hollywood', 120),
('What Happens in Vegas', 2008, 'Fox', 'English', 'Comedy', 99, 219.37, 'Hollywood', 130),
('Water For Elephants', 2011, '20th Century Fox', 'English', 'Drama', 120, 117.09, 'Hollywood', 140),
('Waitress', 2007, 'Independent', 'English', 'Romance', 108, 22.18, 'Hollywood', 150),
('Twilight', 2008, 'Summit', 'English', 'Romance', 122, 376.66, 'Hollywood', 160),
('Penelope', 2008, 'Summit', 'English', 'Comedy', 144, 20.74, 'Hollywood', 170),
('Over Her Dead Body', 2008, 'New Line', 'English', 'Comedy', 95, 20.71, 'Hollywood', 180),
('My Week with Marilyn', 2011, 'The Weinstein Company', 'English', 'Drama', 99, 8.26, 'Hollywood', 190),
('Music and Lyrics', 2007, 'Warner Bros.', 'English', 'Romance', 104, 145.9, 'Hollywood', 200),
('Leap Year', 2010, 'Universal', 'English', 'Comedy', 100, 32.59, 'Hollywood', 210),
('Knocked Up', 2007, 'Universal', 'English', 'Comedy', 129, 219, 'Hollywood', 220),
('Jane Eyre', 2011, 'Universal', 'English', 'Romance', 120, 30.15, 'Hollywood', 230),
('Good Luck Chuck', 2007, 'Lionsgate', 'English', 'Comedy', 101, 59.19, 'Hollywood', 240),
('Going the Distance', 2010, 'Warner Bros.', 'English', 'Comedy', 103, 42.05, 'Hollywood', 250),
('Gnomeo and Juliet', 2011, 'Disney', 'English', 'Animation', 84, 193.97, 'Hollywood', 260),
('Ghosts of Girlfriends Past', 2009, 'Warner Bros.', 'English', 'Comedy', 100, 102.22, 'Hollywood', 270),
('Four Christmases', 2008, 'Warner Bros.', 'English', 'Comedy', 88, 161.83, 'Hollywood', 280),
('Fireproof', 2008, 'Independent', 'English', 'Drama', 122, 33.47, 'Hollywood', 290),
('Enchanted', 2007, 'Disney', 'English', 'Comedy', 107, 340.49, 'Hollywood', 300),
('Dear John', 2010, 'Sony', 'English', 'Drama', 108, 114.97, 'Hollywood', 310),
('Beginners', 2011, 'Independent', 'English', 'Comedy', 105, 14.31, 'Hollywood', 320),
('3 Idiots', 2009, 'Vinod Chopra Films', 'Hindi', 'Comedy', 171, 4000, 'Bollywood', 330),
('Lagaan', 2001, 'Aamir Khan Productions', 'Hindi', 'Romance', 224, 659, 'Bollywood', 340),
('My Name Is Khan', 2010, 'Dharma Productions', 'Hindi', 'Drama', 165, 48.77, 'Bollywood', 350),
('Baahubali', 2015, 'Arka Media Works', 'Telugu', 'Thriller', 159, 6500, 'Bollywood', 360),
('Dilwale Dulhania Le Jayenge', 1995, 'Yash Chopra', 'Hindi', 'Romance', 189, 2000, 'Bollywood', 380),
('Oh My God', 2012, NULL, 'Hindi', 'Comedy', 165, 1200, 'Bollywood', 390),
('Pushpa', 2021, 'Mythri Movie Makers', 'Telugu', 'Drama', 179, 3730, 'Bollywood', 370);
GO

--Create the Movie_Actor table with constraints and specifications
CREATE TABLE mov.Movie_Actor (
    Actor_ID INT NOT NULL IDENTITY(10, 1) CONSTRAINT PK_Actor_ID PRIMARY KEY CLUSTERED,
    Actor_First_Name VARCHAR(50),
    Actor_Last_Name VARCHAR(50),
    Actor_Age_in_Years INT,
    Actor_Location VARCHAR(100),
    Movie_ID INT CONSTRAINT FK_Movie_ID FOREIGN KEY REFERENCES mov.Movies(Movie_ID),
    CreatedOn DATE CONSTRAINT DF_CreatedOn_Actor DEFAULT GETDATE() NOT NULL,
    );
GO

--insert values into Movie_Actor table. Did not add Actor_ID or CreatedOn values as they are auto generated from constraints.
INSERT INTO mov.Movie_Actor (Actor_First_Name, Actor_Last_Name, Actor_Age_in_Years, Actor_Location, Movie_ID)
VALUES
('Seth', 'Rogen', 53, 'Los Angeles', 1000),
('Michael', 'Cera', 49, 'New York', 1001),
('Josh', 'Duhamel', 37, 'North Dakota', 1002),
('Jason', 'Sudeikis', 60, 'Kansas', 1003),
('Robert', 'Pattinson', 45, 'Los Angeles', 1004),
('Nathan', 'Fillion', 55, 'Canada', 1005),
('Robert', 'Pattinson', 45, 'Los Angeles', 1006),
('James', 'McAvoy', 49, 'Scotland', 1007),
('Paul', 'Rudd', 52, 'New York', 1008),
('Kenneth', 'Branagh', 44, 'Northern Ireland', 1009),
('Hugh', 'Grant', 58, 'London', 1010),
('Matthew', 'Goode', 46, 'England', 1011),
('Judd', 'Apatow', 58, 'Los Angeles', 1012),
('Michael', 'Fassbender', 46, 'Germany', 1013),
('Dane', 'Cook', 52, 'United States', 1014),
('Jason', 'Sudeikis', 60, 'Kansas', 1015),
('Kelly', 'Asbury', 76, 'United States', 1016),
('Matthew', 'McConaughey', 52, 'Los Angeles', 1017),
('Vince', 'Vaughn', 60, 'Minnesota', 1018),
('Kirk', 'Cameron', 59, 'United States', 1019),
('James', 'Marsden', 50, 'Columbia', 1020),
('Channing', 'Tatum', 58, 'Alabama', 1021),
('Mike', 'Mills', 37, 'New York', 1022),
('Aamir', 'Khan', 52, 'India', 1023),
('Aamir', 'Khan', 52, 'India', 1024),
('Shah Rukh', 'Khan', 53, 'India', 1025),
('Prabhas', NULL, 53, 'India', 1026),
('Allu', 'Arjun', 49, 'India', 1027),
('Shah Rukh', 'Khan', 53, 'India', 1028),
('Akshay', 'Kumar', 50, 'India', 1029);
GO

--Create the Movie_Rating table with constraints and specifications
CREATE TABLE mov.Movie_Rating (
    Movie_Rating_ID INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_Movie_Rating_ID PRIMARY KEY CLUSTERED,
    Rating_Audience_Score VARCHAR(50),
    Rating_Rotten_Tomatoes VARCHAR(50),
    Movie_ID INT CONSTRAINT FK_Movie_Rating_Movie_ID FOREIGN KEY (Movie_ID) REFERENCES mov.Movies(Movie_ID),
    CreatedOn DATE CONSTRAINT DF_CreatedOn_Rating DEFAULT GETDATE() NOT NULL,
);
GO

--Insert records into the Movie_Rating table. Did not add Movie_Rating_ID or CreatedOn values as they are auto generated from constraints.
INSERT INTO mov.Movie_Rating (Rating_Audience_Score, Rating_Rotten_Tomatoes, Movie_ID)
VALUES
('70', '64', 1000),
('52', '68', 1001),
('44', '15', 1002),
('72', '28', 1003),
('72', '60', 1004),
('67', '89', 1005),
('82', '49', 1006),
('74', '52', 1007),
('47', '15', 1008),
('84', '83', 1009),
('70', '63', 1010),
('49', '21', 1011),
('83', '91', 1012),
('77', '85', 1013),
('61', '3', 1014),
('56', '53', 1015),
('52', '56', 1016),
('47', '27', 1017),
('52', '26', 1018),
('51', '40', 1019),
('80', '93', 1020),
('66', '29', 1021),
('80', '84', 1022),
('95', '100', 1023),
('81', '95', 1024),
('79', '83', 1025),
('80', '90', 1026),
('76', '82', 1027),
('85', '100', 1028),
('81', '74', 1029);
GO

/*
table creation complete
Created 4 tables in total:
mov.Movie_Director;
mov.Movies;
mov.Movie_Actor;
mov.Movie_Rating;
*/

/* Queries
7 sets of queries
Nicole - Q13 - System Info Queries
*/

--Retrieve the list of all Databases.

--Switch to master Database
USE [master]
GO
SELECT name
FROM sys.databases
WHERE state_desc = 'ONLINE';
GO

--Display the byte size of all tables in databases.
USE [Movies]
GO
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
GO

--Get First Date of Current Month.
SELECT DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) AS 'First Date of Current Month';
GO

SELECT DATETRUNC(GETDATE(), AS 'First Date of Current Month';
GO

--Get Last date of Current month.
SELECT EOMONTH(GETDATE()) AS 'Last Date of Current Month';

SELECT NEXTMONTH(GETDATE()) 