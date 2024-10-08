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



-- Insert random data into the Platform table
INSERT INTO Platform (platform_name) VALUES 
('YouTube'),
('Twitch'),
('Facebook Gaming'),
('Kick'),
('Trovo');

-- Insert random data into the Streamers table
INSERT INTO Streamers (name, member_id, platform_id) VALUES
('Fuwawa', 'FUW123', FLOOR(1 + RAND() * 5)),
('Mococo', 'MOC456', FLOOR(1 + RAND() * 5)),
('Gura', 'GUR789', FLOOR(1 + RAND() * 5)),
('Calli', 'CAL123', FLOOR(1 + RAND() * 5)),
('Kronii', 'KRO456', FLOOR(1 + RAND() * 5));

-- Insert random data into the Stream table
INSERT INTO `Stream` (streamer_id, platform_id, date, title, tags, viewer_count, sub_count) VALUES
(FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5), '2024-10-08', 'Let''s Play Minecraft', 'gaming, minecraft', FLOOR(100 + RAND() * 900), FLOOR(10 + RAND() * 90)),
(FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5), '2024-10-07', 'Zatsudan Stream', 'talk, zatsudan', FLOOR(100 + RAND() * 900), FLOOR(10 + RAND() * 90)),
(FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5), '2024-10-06', 'Collaborating with Friends', 'collab, gaming', FLOOR(100 + RAND() * 900), FLOOR(10 + RAND() * 90)),
(FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5), '2024-10-05', 'Horror Game Special', 'gaming, horror', FLOOR(100 + RAND() * 900), FLOOR(10 + RAND() * 90)),
(FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5), '2024-10-04', 'Singing Karaoke!', 'music, karaoke', FLOOR(100 + RAND() * 900), FLOOR(10 + RAND() * 90));

-- Insert random data into the Groups table
INSERT INTO `Groups` (group_name) VALUES
('Hololive'),
('Nijisanji'),
('VShojo'),
('Independents'),
('Myth');

SELECT st.title AS stream_title, s.name AS streamer_name, st.date, st.viewer_count
FROM `Stream` st
JOIN Streamers s ON st.streamer_id = s.streamer_id
WHERE s.name = 'Fuwawa' -- Replace 'Fuwawa' with any streamer's name, or remove this line for all recent streams
ORDER BY st.date DESC
LIMIT 10;

SELECT s.name AS streamer_name, p.platform_name, AVG(st.viewer_count) AS avg_viewers
FROM `Stream` st
JOIN Streamers s ON st.streamer_id = s.streamer_id
JOIN Platform p ON st.platform_id = p.platform_id
GROUP BY s.name, p.platform_name
ORDER BY avg_viewers DESC;

SELECT s.name AS streamer_name, SUM(st.sub_count) AS total_subscribers
FROM `Stream` st
JOIN Streamers s ON st.streamer_id = s.streamer_id
GROUP BY s.name
ORDER BY total_subscribers DESC
LIMIT 5;

SELECT st.title AS stream_title, s.name AS streamer_name, st.date, st.tags, st.viewer_count
FROM `Stream` st
JOIN Streamers s ON st.streamer_id = s.streamer_id
WHERE st.tags LIKE '%gaming%' -- Replace 'gaming' with any other tag
ORDER BY st.viewer_count DESC;

SELECT st.date, st.title AS stream_title, st.viewer_count
FROM `Stream` st
JOIN Streamers s ON st.streamer_id = s.streamer_id
WHERE s.name = 'Mococo' -- Replace 'Mococo' with any streamer's name
ORDER BY st.date ASC;
