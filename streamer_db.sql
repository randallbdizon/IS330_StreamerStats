DROP DATABASE IF EXISTS streamer_db;
CREATE DATABASE streamer_db;
USE streamer_db;

-- Tables
CREATE TABLE Platforms (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Logins (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    admin TINYINT(1) DEFAULT 0
);

CREATE TABLE `Mediums` (
    medium_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Streamers (
    streamer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE, -- Maybe differentiate between username and first name and/or last name
    member_id VARCHAR(50),
    platform_id INT,  -- Ensure this data type matches with the primary key in Platform
    medium_id INT,
    website VARCHAR(255), -- Added column for the streaming site link
    FOREIGN KEY (medium_id) REFERENCES `Mediums`(medium_id),
    FOREIGN KEY (platform_id) REFERENCES Platforms(platform_id) -- Foreign key references Platform
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

CREATE TABLE Projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    streamer_id INT,
    project_name VARCHAR(255) NOT NULL,
    description TEXT,
    project_image_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (streamer_id) REFERENCES Streamers(streamer_id)
);

-- Inserts

INSERT INTO Platforms (name) VALUES 
('YouTube'),
('Twitch'),
('Facebook'),
('Kick'),
('Trovo');

INSERT INTO `Mediums` (name) VALUES
('VTuber'),
('PNG'),
('Webcam');

INSERT INTO Streamers (name, member_id, platform_id, medium_id, website) VALUES
('DarukaEon', 'DAR123', 3, 2, 'https://darukaeon.github.io/'),
('Riven_Black', 'RIV456', 1, 3, 'https://www.twitch.tv/riven_black'),
('Senzawa', 'SEN626', 1, 3, 'https://www.youtube.com/@senzawa'),
('Defii_Azrul', 'DEF789', 2, 1, 'https://www.twitch.tv/itbedefii');

INSERT INTO `Streams` (streamer_id, platform_id, date, title, tags, viewer_count, follow_count) VALUES
(1, 3, '2024-10-08', 'Let''s Play Minecraft', 'gaming, minecraft', 5, 5),
(2, 3, '2024-10-07', 'Working on Guitar Tracks', 'music, guitar', 3, 8),
(3, 1, '2024-10-07', 'Magic Mondays', 'collab, gaming', 15, 13);

INSERT INTO `Logins` (username, password, admin) VALUES
('DarukaEon', '$2y$10$Hmb1zV25aDKj9IG3BWOk4eKGfucJ4AZIjtCdEnSQTMbAe1uzh1x0y', 1);

-- Select statements below

SELECT * FROM Logins;