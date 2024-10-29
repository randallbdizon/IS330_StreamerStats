DROP DATABASE IF EXISTS streamerStat;
CREATE DATABASE streamerStat;
USE streamerStat;

-- First, create the Platforms table
CREATE TABLE Platforms (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE `Mediums` (
    medium_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Then, create the Streamers table that references Platforms
CREATE TABLE Streamers (
    streamer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE, -- Maybe differentiate between username and first name and/or last name
    member_id VARCHAR(50),
    platform_id INT,  -- Ensure this data type matches with the primary key in Platform
    medium_id INT,
    website VARCHAR(255), -- Added column for the streaming site link
    FOREIGN KEY (medium_id) REFERENCES `mediums`(medium_id),
    FOREIGN KEY (platform_id) REFERENCES Platforms(platform_id) -- Foreign key references Platform
    -- add a password hash
);

CREATE TABLE `Streams` (
    stream_id INT AUTO_INCREMENT PRIMARY KEY,
    streamer_id INT,
    platform_id INT,
    medium_id INT,
    date DATE,
    title VARCHAR(200) NOT NULL,
    tags TEXT, -- Split up tags to their own tables
    viewer_count INT,
    follow_count INT,
    FOREIGN KEY (streamer_id) REFERENCES Streamers(streamer_id),
    FOREIGN KEY (platform_id) REFERENCES Platforms(platform_id),
    FOREIGN KEY (medium_id) REFERENCES `mediums`(medium_id)
);









-- A bunch of inserts here

-- Insert data into the Platform table
INSERT INTO Platforms (name) VALUES 
('YouTube'),
('Twitch'),
('Facebook'),
('Kick'),
('Trovo');

-- Insert data into the mediums table
INSERT INTO `mediums` (name) VALUES
('VTuber'),
('PNG'),
('Webcam');

-- Insert data into the Streamers table
INSERT INTO Streamers (name, member_id, platform_id, medium_id, website) VALUES
('DarukaEon', 'DAR123', 3, 2, 'https://darukaeon.github.io/'),
('Riven_Black', 'RIV456', 1, 3, 'https://www.twitch.tv/riven_black'),
('Defii_Azrul', 'DEF789', 2, 1, 'https://www.twitch.tv/itbedefii');

-- Insert data into the Stream table
INSERT INTO `Streams` (streamer_id, platform_id, date, title, tags, viewer_count, follow_count) VALUES
(1, 3, '2024-10-08', 'Let''s Play Minecraft', 'gaming, minecraft', 5, 5),
(2, 3, '2024-10-07', 'Working on Guitar Tracks', 'music, guitar', 3, 8),
(3, 1, '2024-10-07', 'Magic Mondays', 'collab, gaming', 15, 13);






-- Select statements here

SELECT `Streams`.title, Streamers.name, `Streams`.date, `Streams`.viewer_count AS viewers
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
WHERE Streamers.name = 'Riven_Black' -- Replace 'Riven_Black' with any streamer's name, or remove this line for all recent streams
ORDER BY `Streams`.date DESC
LIMIT 10;

SELECT Streamers.name, Platforms.name, AVG(`Streams`.viewer_count)
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
JOIN Platforms ON `Streams`.platform_id = Platforms.platform_id
JOIN `mediums` ON `Streams`.medium_id = `mediums`.medium_id
GROUP BY Streamers.name, Platforms.name
ORDER BY AVG(`Streams`.viewer_count) DESC;

SELECT Streamers.name, SUM(`Streams`.follow_count)
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
GROUP BY Streamers.name
ORDER BY SUM(`Streams`.follow_count) DESC
LIMIT 5;

SELECT `Streams`.title, Streamers.name, `Streams`.date, `Streams`.tags, `Streams`.viewer_count
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
WHERE `Streams`.tags LIKE '%gaming%' -- Replace 'gaming' with any other tag
ORDER BY `Streams`.viewer_count DESC;

SELECT `Streams`.date, `Streams`.title, `Streams`.viewer_count
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
WHERE Streamers.name = 'DarukaEon' -- Replace 'Mococo' with any streamer's name
ORDER BY `Streams`.date ASC;


-- For IS330 Lab Project

-- Inserting a new streamer into the Streamers table
INSERT INTO Streamers (name, member_id, platform_id, medium_id) 
VALUES ('Amelia', 'AME321', 1, 1);

-- Updating a streamer's name
UPDATE Streamers
SET name = 'Amelia Watson'
WHERE member_id = 'AME321';

-- Selecting all streamers from the Streamers table
SELECT * FROM Streamers;

-- Selecting stream title and the name of the streamer who hosted it
SELECT `Streams`.title, Streamers.name
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id;

-- Deleting a streamer from the Streamers table
DELETE FROM Streamers
WHERE member_id = 'AME321';