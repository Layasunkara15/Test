create database IF NOT EXISTS kdrama;
use kdrama;

CREATE TABLE IF NOT EXISTS Kdramas (
    DramaID INT AUTO_INCREMENT KEY,
    Title VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    ReleaseYear INT CHECK (ReleaseYear >= 1900 AND ReleaseYear <= 2024),
    NumberOfSeasons INT CHECK (NumberOfSeasons >= 1)
);


CREATE TABLE IF NOT EXISTS Episodes (
    EpisodeID INT PRIMARY KEY,
    DramaID INT,
    SeasonNumber INT CHECK (SeasonNumber >= 1),
    EpisodeNumber INT CHECK (EpisodeNumber >= 1),
    Title VARCHAR(255) NOT NULL,
    Duration INT CHECK (Duration > 0),  -- Duration in minutes
    AirDate DATE,
    FOREIGN KEY (DramaID) REFERENCES Kdramas(DramaID)
);

CREATE TABLE IF NOT EXISTS Reviews (
    ReviewID INT PRIMARY KEY,
    DramaID INT,
    ReviewerName VARCHAR(255) NOT NULL,
    ReviewText TEXT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 10),
    ReviewDate DATE ,
    FOREIGN KEY (DramaID) REFERENCES Kdramas(DramaID)
);

INSERT INTO Kdramas (DramaID, Title, Genre, ReleaseYear, NumberOfSeasons) VALUES
(1, 'Crash Landing on You', 'Romance', 2019, 1),
(2, 'Itaewon Class', 'Drama', 2020, 1),
(3, 'Kingdom', 'Thriller', 2019, 2),
(4, 'Hotel Del Luna', 'Fantasy', 2019, 1),
(5, 'Goblin', 'Fantasy', 2016, 1),
(6, 'Vincenzo', 'Crime', 2021, 1),
(7, 'Start-Up', 'Drama', 2020, 1),
(8, 'Sweet Home', 'Horror', 2020, 1),
(9, 'Lovely Runner','Rom-com,Fantasy' , 2024,1),
(10,'Queen of Tears','Melodrama',2024,1),
(11,'Boys over Flowers','Rom-com',2009,1),
(12,'Business Proposal','Rom-com',2021,1);

INSERT INTO Episodes (EpisodeID, DramaID, SeasonNumber, EpisodeNumber, Title, Duration, AirDate) VALUES
(1, 1, 1, 1, 'Episode 1', 70, '2019-12-14'),
(2, 1, 1, 2, 'Episode 2', 70, '2019-12-15'),
(3, 2, 1, 1, 'Episode 1', 70, '2020-01-31'),
(4, 3, 1, 1, 'Episode 1', 55, '2019-01-25'),
(5, 4, 1, 1, 'Episode 1', 60, '2019-07-13'),
(6, 5, 1, 1, 'Episode 1', 82, '2016-12-02'),
(7, 6, 1, 1, 'Episode 1', 80, '2021-02-20'),
(8, 7, 1, 1, 'Episode 1', 84, '2020-10-17');

INSERT INTO Reviews (ReviewID, DramaID, ReviewerName, ReviewText, Rating) VALUES
(1, 1, 'Anuradha', 'Amazing story and acting!', 9),
(2, 1, 'Biplab', 'Very entertaining and emotional.', 8),
(3, 2, 'Chirag', 'Inspiring and well-made.', 9),
(4, 3, 'David', 'Thrilling and engaging.', 8),
(5, 4, 'Ella', 'Unique and captivating.', 9),
(6, 5, 'Francessca', 'A masterpiece in fantasy genre.', 10),
(7, 6, 'George', 'Intense and thrilling.', 8),
(8, 7, 'Hailey', 'Motivational and touching.', 9);
SELECT * FROM KDramas;
SELECT * FROM EPISODES;
SELECT * FROM REVIEWS;

Update Kdramas
set NumberOfSeasons= 2
where DramaID = 8;

SELECT * FROM Kdramas ORDER BY ReleaseYear;

SELECT * FROM Episodes WHERE DramaID = 1 ORDER BY SeasonNumber, EpisodeNumber;

SELECT * FROM Reviews WHERE DramaID = 1 ORDER BY ReviewDate DESC;

SELECT AVG(Rating) AS AverageRating FROM Reviews WHERE DramaID = 1;

SELECT d.Title, AVG(r.Rating) AS AverageRating
FROM Kdramas d
JOIN Reviews r ON d.DramaID = r.DramaID
GROUP BY d.Title
ORDER BY AverageRating DESC
LIMIT 5;

UPDATE Kdramas
SET Genre = 'Romantic Comedy'
WHERE DramaID = 1;

UPDATE Episodes
SET Title = 'New Episode Title'
WHERE EpisodeID = 2;

DELETE FROM Reviews
WHERE ReviewID = 1;

SELECT COUNT(*) AS TotalKdramas FROM Kdramas;

SELECT AVG(Duration) AS AverageDuration FROM Episodes;

SELECT UPPER(Title) AS DramaTitle
FROM Kdramas
ORDER BY ReleaseYear;

SELECT Title, ReleaseYear
FROM Kdramas
WHERE ReleaseYear >= YEAR(CURRENT_DATE) - 3
ORDER BY ReleaseYear DESC;

DELIMITER //
CREATE PROCEDURE GetDramaReviews (IN drama_id INT)
BEGIN
    SELECT ReviewerName, ReviewText, Rating, ReviewDate
    FROM Reviews
    WHERE DramaID = drama_id
    ORDER BY ReviewDate DESC;
END //

CALL GetDramaReviews(1);


