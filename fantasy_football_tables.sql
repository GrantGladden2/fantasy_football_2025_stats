CREATE DATABASE IF NOT EXISTS fantasy_stats;
USE fantasy_stats;

-- Create table for game/player information
CREATE TABLE information (
	player_id VARCHAR(50) PRIMARY KEY,
    player TEXT NOT NULL,
    team TEXT,
    position TEXT,
    age INT,
    games INT
);

-- Create table for passing stats
CREATE TABLE passing (
    completions INT,
    attempts INT,
    yards INT,
    touchdowns INT,
    interceptions INT,
    player_id VARCHAR(50),
    FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for rushing stats
CREATE TABLE rushing (
	attempts INT,
    yards INT,
    yards_per_attempt DECIMAL(10,2),
    touchdowns INT,
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for receiving
CREATE TABLE receiving (
	targets INT,
    receptions INT,
    yards INT,
    yards_per_reception DECIMAL(10,2),
    touchdowns INT,
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for fumbles
CREATE TABLE fumbles (
	fumbles INT,
    fumbles_lost INT,
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for scoring
CREATE TABLE scoring (
	total_touchdowns INT,
    two_point_made INT,
    two_point_passes INT,
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for fantasy
CREATE TABLE fantasy (
	fantasy_points_ppr INT,
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);
