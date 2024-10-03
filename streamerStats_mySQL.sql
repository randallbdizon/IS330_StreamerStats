DROP DATABASE IF EXISTS streamerStat;
CREATE DATABASE streamerStat;
USE streamerStat;

CREATE TABLE Streamers (
    streamer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    member_id VARCHAR(50),
    platform_id INT,
    FOREIGN KEY (platform_id) REFERENCES Platform(platform_id)
);

CREATE TABLE Platform (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    platform_name VARCHAR(100) NOT NULL
);

CREATE TABLE Stream (
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

CREATE TABLE Groups (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    group_name VARCHAR(100) NOT NULL
);
