# Fantasy Football 2025 Season Stats
from extract_stats import web_to_table
import pandas as pd

# Objective of this file:
# 1. Load in data from the online ESPN website into an html file
web_link = 'https://fantasydata.com/nfl/fantasy-football-leaders?page=1'
headers, stats = web_to_table(web_link)

# 2. Create a dataframe based on the headers and data collected
fantasy_football_df = pd.DataFrame(stats, columns=headers)

# 3. Export a CSV file from the giant table
fantasy_football_df.to_csv('fantasy_football_stats.csv')
