-- Create table for game/player information
DROP TABLE IF EXISTS information;
CREATE TABLE information (
    player TEXT NOT NULL,
    team TEXT,
    position TEXT,
    age INT,
    games INT,
    player_id VARCHAR(50) PRIMARY KEY
);

-- Create table for passing stats
DROP TABLE IF EXISTS passing;
CREATE TABLE passing (
    completions DECIMAL(10,2),
    attempts DECIMAL(10,2),
    yards DECIMAL(10,2),
    touchdowns DECIMAL(10,2),
    interceptions DECIMAL(10,2),
    player_id VARCHAR(50),
    FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for rushing stats
DROP TABLE IF EXISTS rushing;
CREATE TABLE rushing (
	attempts DECIMAL(10,2),
    yards DECIMAL(10,2),
    yards_per_attempt DECIMAL(10,2),
    touchdowns DECIMAL(10,2),
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for receiving
DROP TABLE IF EXISTS receiving;
CREATE TABLE receiving (
	targets DECIMAL(10,2),
    receptions DECIMAL(10,2),
    yards DECIMAL(10,2),
    yards_per_reception DECIMAL(10,2),
    touchdowns DECIMAL(10,2),
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for fumbles
DROP TABLE IF EXISTS fumbles;
CREATE TABLE fumbles (
	fumbles DECIMAL(10,2),
    fumbles_lost DECIMAL(10,2),
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for scoring
DROP TABLE IF EXISTS scoring;
CREATE TABLE scoring (
    two_point_made DECIMAL(10,2),
    two_point_passes DECIMAL(10,2),
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);

-- Create table for fantasy
DROP TABLE IF EXISTS fantasy;
CREATE TABLE fantasy (
	fantasy_points_ppr DECIMAL(10,3),
    player_id VARCHAR(50),
	FOREIGN KEY (player_id) REFERENCES information(player_id)
);
