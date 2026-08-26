-- Create table for all paassing data
WITH passing_table AS (
    SELECT
        games,
        player,
        position,
        team,
        points::DECIMAL(5,2),
        (points/attempts)::DECIMAL(3,2) AS pts_per_attempt,
        (pass_yards/25)::DECIMAL(5,2) AS pass_yd_pts,
        (pass_tds*4)::DECIMAL(5,2) AS pass_td_pts,
        (rush_yards/10)::DECIMAL(5,2) AS rush_yd_pts,
        (rush_tds*6)::DECIMAL(5,2) AS rush_td_pts,
        fumbles
        FROM (
            SELECT
                i.*,
                p.completions,
                p.attempts,
                p.yards AS pass_yards, 
                p.touchdowns AS pass_tds,
                p.interceptions,
                s.two_point_passes,
                fu.fumbles,
                fa.fantasy_points_ppr AS points,
                r.yards AS rush_yards,
                r.touchdowns AS rush_tds,
                ROW_NUMBER() OVER (
                    PARTITION BY i.team
                    ORDER BY fa.fantasy_points_ppr DESC
                ) AS rn
            FROM information i
            LEFT JOIN passing p ON i.player_id = p.player_id
            LEFT JOIN scoring s ON i.player_id = s.player_id
            LEFT JOIN fumbles fu ON i.player_id = fu.player_id
            LEFT JOIN fantasy fa ON i.player_id = fa.player_id
            LEFT JOIN rushing r ON i.player_id = r.player_id
            WHERE p.attempts IS NOT NULL
            AND position = 'QB'
            AND fa.fantasy_points_ppr IS NOT NULL
        ) AS t1
        WHERE rn = 1
        AND games > 8
)

SELECT *
FROM passing_table
ORDER BY pts_per_attempt DESC;

-- Create a table for all rushing data
WITH rushing_table AS (
    SELECT
        games,
        player,
        position,
        team,
        points::DECIMAL(5,2),
        (points/rush_attempts)::DECIMAL(5,2) AS pts_per_attempt,
        rush_attempts,
        rush_ypa,
        (rush_yds/10)::DECIMAL(5,2) AS rush_yd_pts,
        (rush_tds*6)::DECIMAL(5,2) AS rush_td_pts,
        receptions,
        (rec_yds/10)::DECIMAL(5,2) AS rec_yd_pts,
        (rec_tds*6)::DECIMAL(5,2) AS rec_td_pts,
        fumbles
        FROM (
            SELECT
                i.player,
                i.position,
                i.games,
                i.team,
                ru.attempts AS rush_attempts,
                ru.yards AS rush_yds,
                ru.yards_per_attempt AS rush_ypa,
                ru.touchdowns AS rush_tds,
                re.receptions,
                re.yards AS rec_yds,
                re.touchdowns AS rec_tds,
                fu.fumbles,
                fa.fantasy_points_ppr AS points,
                ROW_NUMBER() OVER (
                    PARTITION BY i.team
                    ORDER BY fa.fantasy_points_ppr DESC
                ) AS rn,
                i.player_id
            FROM information i
            LEFT JOIN rushing ru ON i.player_id = ru.player_id
            LEFT JOIN receiving re ON i.player_id = re.player_id
            LEFT JOIN fumbles fu ON i.player_id = fu.player_id
            LEFT JOIN fantasy fa ON i.player_id = fa.player_id
            WHERE ru.attempts IS NOT NULL
            AND position = 'RB'
            AND fa.fantasy_points_ppr IS NOT NULL
        ) AS t1
        WHERE rn = 1 OR rn = 2
        AND games > 8
)

SELECT *
FROM rushing_table
ORDER BY points DESC;


-- Create a table for all receiving data
WITH receiving_table AS (
    SELECT
        games,
        player,
        position,
        team,
        points::DECIMAL(5,2),
        (points/targets)::DECIMAL(5,2) AS pts_per_target,
        targets,
        receptions,
        ((receptions/targets)*100)::INT AS catch_percentage,
        (rec_yds/10)::DECIMAL(5,2) AS rec_yd_pts,
        (rec_tds*6)::DECIMAL(5,2) AS rec_td_pts,
        rush_ypa,
        (rush_yds/10)::DECIMAL(5,2) AS rush_yd_pts,
        (rush_tds*6)::DECIMAL(5,2) AS rush_td_pts,
        fumbles
        FROM (
            SELECT
                i.player,
                i.position,
                i.games,
                i.team,
                re.targets,
                re.receptions,
                re.yards AS rec_yds,
                re.touchdowns AS rec_tds,
                ru.yards AS rush_yds,
                ru.yards_per_attempt AS rush_ypa,
                ru.touchdowns AS rush_tds,
                fu.fumbles,
                fa.fantasy_points_ppr AS points,
                ROW_NUMBER() OVER (
                    PARTITION BY i.team
                    ORDER BY fa.fantasy_points_ppr DESC
                ) AS rn,
                i.player_id
            FROM information i
            LEFT JOIN rushing ru ON i.player_id = ru.player_id
            LEFT JOIN receiving re ON i.player_id = re.player_id
            LEFT JOIN fumbles fu ON i.player_id = fu.player_id
            LEFT JOIN fantasy fa ON i.player_id = fa.player_id
            WHERE ru.attempts IS NOT NULL
            AND position = 'WR'
            OR position = 'TE'
            AND fa.fantasy_points_ppr IS NOT NULL
        ) AS t1
        WHERE rn = 1 OR rn = 2 OR rn = 3
        AND games > 8
)

SELECT *
FROM receiving_table
ORDER BY points DESC;