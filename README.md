# 2025 Fantasy Football Dashboard

An end-to-end data project analyzing final 2025 NFL season stats to help prepare for a 2026 fantasy football draft. Raw stats are scraped and cleaned in Python, structured and queried in SQL, and visualized in an interactive Tableau dashboard — currently built out for QBs, with the same pipeline used for RB, WR, and TE.

## What it does

Pulls full-season 2025 stats for every QB, RB, WR, and TE and turns them into draft-prep visuals: fantasy points, per-game efficiency, scatter plots comparing yardage splits, and turnover/interception trends. Built for anyone drafting a QB (or other position) in 2026, or who just likes digging into fantasy stats.

## Dashboard preview

**Project explorer**

![Project structure](project_structure.png)

**QB Dashboard**

![QB Dashboard](qb_dashboard_screenshot.png)

The dashboard lets you filter by stat (fantasy points, passing/rushing yards and TDs, interceptions, fumbles), and click any bar or scatterplot marker to drill into a specific player's point distribution (pass yards, pass TDs, rush yards, rush TDs).

## Data

- **Source:** [Pro Football Reference — 2025 Fantasy stats](https://www.pro-football-reference.com/years/2025/fantasy.htm)
- **Scope:** Final 2025 regular season stats for all QB/RB/WR/TE
- **Categories included:** fantasy points (PPR), passing, rushing, receiving, scoring (2-pt conversions), and fumbles

## Tech stack & workflow

| Tool | What it did |
|------|-------------|
| **Python** | Scraped the stats table from the source website (`extract_stats.py`) and cleaned/split the raw data into normalized tables by category (`data_query.py`, `main.py`) |
| **SQL** | Defined the relational schema (`create_tables.sql`) and wrote queries using joins, window functions, `WHERE`/`GROUP BY`/`ORDER BY`, and views to shape position-specific stat tables (`query.sql`) |
| **Tableau** | Built the interactive dashboard using calculated fields, parameters, case statements, containers, legends, bar charts, and scatter plots |

### Pipeline

1. **Extract** — `extract_stats.py` scrapes the raw stats HTML table from Pro Football Reference.
2. **Clean & split** — `main.py` runs `data_query.py` functions to strip junk characters/columns, fill missing values, dedupe players, and split the data into category-specific CSVs (`information`, `passing`, `rushing`, `receiving`, `fumbles`, `scoring`, `fantasy`).
3. **Load & structure** — `create_tables.sql` builds the SQL schema (one `information` table joined to category tables via `player_id`).
4. **Query** — `query.sql` joins the tables and computes position-specific outputs (e.g., points per attempt/target, points from each yardage/TD category), producing final tables like `qb_fantasy_table.csv`, `rb_fantasy_table.csv`, `wr_fantasy_table.csv`.
5. **Visualize** — Those tables feed the Tableau workbooks (`qb_dashboard.twb`, `rb_dashboard.twb`, `wr_dashboard.twb`).

## Project structure

```
Fantasy Football 25 Season/
├── data/
│   ├── raw/                          # original scraped/downloaded stats
│   └── cleaned/                      # cleaned, split CSVs by category
│       ├── fantasy_football_stats_2025_cleaned.csv
│       ├── information.csv
│       ├── passing.csv
│       ├── rushing.csv
│       ├── receiving.csv
│       ├── fumbles.csv
│       ├── scoring.csv
│       └── fantasy.csv
├── sql/
│   ├── create_tables.sql             # schema definition
│   ├── query.sql                     # position-specific analysis queries
│   └── count_table.csv
├── src/
│   ├── data_query.py                 # cleaning/splitting functions
│   ├── extract_stats.py              # web scraping
│   ├── link_to_table.py
│   └── main.py                       # pipeline entry point
└── tableau/
    ├── final_tables/                 # query outputs feeding Tableau
    │   ├── qb_fantasy_table.csv
    │   ├── rb_fantasy_table.csv
    │   └── wr_fantasy_table.csv
    ├── qb_dashboard.twb
    ├── rb_dashboard.twb
    ├── wr_dashboard.twb
    └── dashboard_background.png / .pptx
```

## Key findings

- **Fantasy points vs. turnovers:** higher-scoring QBs tend to have lower turnover rates overall.
- **Efficiency vs. interceptions:** QBs with higher pass yards *and* rush yards per game tend to throw fewer interceptions.
- **Rushing matters:** several QBs who weren't elite passers still ranked well by making it up on the ground, since rushing yards/TDs are worth more fantasy points per unit than passing.
- **Sleeper pick — Jaxson Dart:** low passing volume, but strong rushing yards and rushing TDs, which carry more fantasy value per yard than passing stats.
- **Undervalued — Trevor Lawrence:** strong passing volume with a solid rushing mix, outside the top 5 overall despite the well-rounded profile (a few interceptions keep him from ranking higher).

## Using the dashboard

- Use the **stat filter** on the left to switch what the bar chart is ranking players by (fantasy points, passing/rushing yards or TDs, interceptions, fumbles).
- **Click a bar or scatterplot marker** to select a player and see their individual point breakdown (pass yards, pass TDs, rush yards, rush TDs) in the detail panel.
- The two scatter plots at the bottom show **passing/rushing yardage vs. fantasy points** and **turnover rate vs. fantasy points**, both colored and sized by total points, to help spot trade-offs at a glance.

## Setup

This project isn't currently packaged for others to re-run end-to-end (the SQL import step is manual/local). The Tableau dashboard is the intended way to explore the data — see "Using the dashboard" above.
