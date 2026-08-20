USE fantasy_stats;

SET GLOBAL local_infile = 1;

-- Load information data
LOAD DATA LOCAL INFILE "C:/Users/Grant/OneDrive/Personal Projects/Fantasy Football 25 Season/information.csv"
INTO TABLE information
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load passing data
LOAD DATA LOCAL INFILE "C:/Users/Grant/OneDrive/Personal Projects/Fantasy Football 25 Season/passing.csv"
INTO TABLE passing
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load rushing data
LOAD DATA LOCAL INFILE "C:/Users/Grant/OneDrive/Personal Projects/Fantasy Football 25 Season/rushing.csv"
INTO TABLE rushing
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load receiving data
LOAD DATA LOCAL INFILE "C:/Users/Grant/OneDrive/Personal Projects/Fantasy Football 25 Season/receiving.csv"
INTO TABLE receiving
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load fumbles data
LOAD DATA LOCAL INFILE "C:/Users/Grant/OneDrive/Personal Projects/Fantasy Football 25 Season/fumbles.csv"
INTO TABLE fumbles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load scoring data
LOAD DATA LOCAL INFILE "C:/Users/Grant/OneDrive/Personal Projects/Fantasy Football 25 Season/scoring.csv"
INTO TABLE scoring
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load fantasy data
LOAD DATA LOCAL INFILE "C:/Users/Grant/OneDrive/Personal Projects/Fantasy Football 25 Season/fantasy.csv"
INTO TABLE fantasy
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;