DROP DATABASE IF EXISTS streamerStat;
CREATE DATABASE streamerStat;
USE streamerStat;

-- First, create the Platform table
CREATE TABLE Platform (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    platform_name VARCHAR(100) NOT NULL
);

-- Then, create the Streamers table that references Platform
CREATE TABLE Streamers (
    streamer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    member_id VARCHAR(50),
    platform_id INT,  -- Ensure this data type matches with the primary key in Platform
    FOREIGN KEY (platform_id) REFERENCES Platform(platform_id) -- Foreign key references Platform
);

CREATE TABLE `Stream` (
    stream_id INT AUTO_INCREMENT PRIMARY KEY,
    streamer_id INT,
    platform_id INT,
    date DATE,
    title VARCHAR(200) NOT NULL,
    tags TEXT,
    viewer_count INT,
    sub_count INT,
    FOREIGN KEY (streamer_id) REFERENCES Streamers(streamer_id),
    FOREIGN KEY (platform_id) REFERENCES Platform(platform_id)
);

CREATE TABLE `Groups` (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    group_name VARCHAR(100) NOT NULL
);

-- Insert data into the Platform table
INSERT INTO Platform (platform_name) VALUES 
('YouTube'),
('Twitch'),
('Facebook Gaming'),
('Kick'),
('Trovo');

-- Insert data into the Streamers table
INSERT INTO Streamers (name, member_id, platform_id) VALUES
('Fuwawa', 'FUW123', 1),
('Mococo', 'MOC456', 2),
('Gura', 'GUR789', 1),
('Calli', 'CAL123', 2),
('Kronii', 'KRO456', 3);

-- Insert data into the Stream table
INSERT INTO `Stream` (streamer_id, platform_id, date, title, tags, viewer_count, sub_count) VALUES
(1, 1, '2024-10-08', 'Let''s Play Minecraft', 'gaming, minecraft', 450, 75),
(2, 2, '2024-10-07', 'Zatsudan Stream', 'talk, zatsudan', 300, 50),
(3, 1, '2024-10-06', 'Collaborating with Friends', 'collab, gaming', 600, 90),
(4, 2, '2024-10-05', 'Horror Game Special', 'gaming, horror', 550, 85),
(5, 3, '2024-10-04', 'Singing Karaoke!', 'music, karaoke', 700, 100);

-- Insert data into the Groups table
INSERT INTO `Groups` (group_name) VALUES
('Myth'),
('Promise'),
('Advent'),
('Justice');


SELECT `Stream`.title, Streamers.name, `Stream`.date, `Stream`.viewer_count
FROM `Stream`
JOIN Streamers ON `Stream`.streamer_id = Streamers.streamer_id
WHERE Streamers.name = 'Fuwawa' -- Replace 'Fuwawa' with any streamer's name, or remove this line for all recent streams
ORDER BY `Stream`.date DESC
LIMIT 10;

SELECT Streamers.name, Platform.platform_name, AVG(`Stream`.viewer_count)
FROM `Stream`
JOIN Streamers ON `Stream`.streamer_id = Streamers.streamer_id
JOIN Platform ON `Stream`.platform_id = Platform.platform_id
GROUP BY Streamers.name, Platform.platform_name
ORDER BY AVG(`Stream`.viewer_count) DESC;

SELECT Streamers.name, SUM(`Stream`.sub_count)
FROM `Stream`
JOIN Streamers ON `Stream`.streamer_id = Streamers.streamer_id
GROUP BY Streamers.name
ORDER BY SUM(`Stream`.sub_count) DESC
LIMIT 5;

SELECT `Stream`.title, Streamers.name, `Stream`.date, `Stream`.tags, `Stream`.viewer_count
FROM `Stream`
JOIN Streamers ON `Stream`.streamer_id = Streamers.streamer_id
WHERE `Stream`.tags LIKE '%gaming%' -- Replace 'gaming' with any other tag
ORDER BY `Stream`.viewer_count DESC;

SELECT `Stream`.date, `Stream`.title, `Stream`.viewer_count
FROM `Stream`
JOIN Streamers ON `Stream`.streamer_id = Streamers.streamer_id
WHERE Streamers.name = 'Mococo' -- Replace 'Mococo' with any streamer's name
ORDER BY `Stream`.date ASC;

