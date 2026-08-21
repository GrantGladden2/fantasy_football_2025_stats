-- Create table for all QB data that shows who had most fantasy points from each team
WITH passing_table AS (
    SELECT
        games,
        player,
        team,
        fumbles,
        (fnt_ppr/attempts)::DECIMAL(3,2) AS pts_per_attempt,
        fnt_ppr::DECIMAL(5,2),
        (pass_yards/25)::DECIMAL(5,2) AS fnt_pass_yds,
        (pass_tds*4)::DECIMAL(5,2) AS fnt_pass_tds,
        (rush_yards/10)::DECIMAL(5,2) AS fnt_rush_yds,
        (rush_tds*6)::DECIMAL(5,2) AS fnt_rush_tds
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
                fa.fantasy_points_ppr AS fnt_ppr,
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
        AND games > 5
)

SELECT
    *,
    (fnt_pass_yds + fnt_pass_tds + fnt_rush_yds + fnt_rush_tds) AS total_check
FROM passing_table
ORDER BY pts_per_attempt DESC;


-- -- Create a table for all rushing data
SELECT *
FROM information



-- Create a table for all receiving data