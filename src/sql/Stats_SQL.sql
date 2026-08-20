DROP DATABASE IF EXISTS orioles_stats;
CREATE DATABASE orioles_stats;
USE orioles_stats;

CREATE TABLE batters;

LOAD DATA LOCAL INFILE 'C:\Users\gglad\OneDrive\Personal Projects\Orioles_2026_Code\batters.csv'
INTO TABLE batters;

SELECT *
FROM batters;