DROP DATABASE IF EXISTS streamerStat;
CREATE DATABASE streamerStat;
USE streamerStat;

-- First, create the Platforms table
CREATE TABLE Platforms (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE `Groups` (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Then, create the Streamers table that references Platforms
CREATE TABLE Streamers (
    streamer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE, -- Maybe differentiate between username and first name and/or last name
    member_id VARCHAR(50),
    platform_id INT,  -- Ensure this data type matches with the primary key in Platform
    group_id INT,
    FOREIGN KEY (group_id) REFERENCES `Groups`(group_id),
    FOREIGN KEY (platform_id) REFERENCES Platforms(platform_id) -- Foreign key references Platform
    -- add a password hash
);

CREATE TABLE `Streams` (
    stream_id INT AUTO_INCREMENT PRIMARY KEY,
    streamer_id INT,
    platform_id INT,
    group_id INT,
    date DATE,
    title VARCHAR(200) NOT NULL,
    tags TEXT, -- Split up tags to their own tables
    viewer_count INT,
    sub_count INT,
    FOREIGN KEY (streamer_id) REFERENCES Streamers(streamer_id),
    FOREIGN KEY (platform_id) REFERENCES Platforms(platform_id),
    FOREIGN KEY (group_id) REFERENCES `Groups`(group_id)
);









-- A bunch of inserts here

-- Insert data into the Platform table
INSERT INTO Platforms (name) VALUES 
('YouTube'),
('Twitch'),
('Facebook'),
('Kick'),
('Trovo');

-- Insert data into the Groups table
INSERT INTO `Groups` (name) VALUES
('Myth'),
('Promise'),
('Advent'),
('Justice');

-- Insert data into the Streamers table
INSERT INTO Streamers (name, member_id, platform_id, group_id) VALUES
('Fuwawa', 'FUW123', 1, 3),
('Mococo', 'MOC456', 2, 3),
('Gura', 'GUR789', 1, 1),
('Calli', 'CAL123', 2, 1),
('Kronii', 'KRO456', 3, 2),
('Gigi', 'GIG789', 5, 4);

-- Insert data into the Stream table
INSERT INTO `Streams` (streamer_id, platform_id, date, title, tags, viewer_count, sub_count) VALUES
(1, 1, '2024-10-08', 'Let''s Play Minecraft', 'gaming, minecraft', 450, 75),
(2, 2, '2024-10-07', 'Zatsudan Stream', 'talk, zatsudan', 300, 50),
(3, 1, '2024-10-06', 'Collaborating with Friends', 'collab, gaming', 600, 90),
(4, 2, '2024-10-05', 'Horror Game Special', 'gaming, horror', 550, 85),
(5, 3, '2024-10-04', 'Singing Karaoke!', 'music, karaoke', 700, 100);







-- Select statements here

SELECT `Streams`.title, Streamers.name, `Streams`.date, `Streams`.viewer_count
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
WHERE Streamers.name = 'Fuwawa' -- Replace 'Fuwawa' with any streamer's name, or remove this line for all recent streams
ORDER BY `Streams`.date DESC
LIMIT 10;

SELECT Streamers.name, Platforms.name, AVG(`Streams`.viewer_count)
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
JOIN Platforms ON `Streams`.platform_id = Platforms.platform_id
JOIN `Groups` ON `Streams`.group_id = `Groups`.group_id
GROUP BY Streamers.name, Platforms.name
ORDER BY AVG(`Streams`.viewer_count) DESC;

SELECT Streamers.name, SUM(`Streams`.sub_count)
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
GROUP BY Streamers.name
ORDER BY SUM(`Streams`.sub_count) DESC
LIMIT 5;

SELECT `Streams`.title, Streamers.name, `Streams`.date, `Streams`.tags, `Streams`.viewer_count
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
WHERE `Streams`.tags LIKE '%gaming%' -- Replace 'gaming' with any other tag
ORDER BY `Streams`.viewer_count DESC;

SELECT `Streams`.date, `Streams`.title, `Streams`.viewer_count
FROM `Streams`
JOIN Streamers ON `Streams`.streamer_id = Streamers.streamer_id
WHERE Streamers.name = 'Mococo' -- Replace 'Mococo' with any streamer's name
ORDER BY `Streams`.date ASC;


-- For IS330 Lab Project

-- Inserting a new streamer into the Streamers table
INSERT INTO Streamers (name, member_id, platform_id, group_id) 
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