# Main function for fantasy football 2025 season stats
# Import packages as needed
from data_query import split_data, read_csv
from pathlib import Path

# Input txt file name and use the function to create the pandas dataframe
project_dir = Path(
    r'C:\Users\Grant\OneDrive\Data Analytics\Personal Projects'
)
data_dir = project_dir / 'Fantasy Football 25 Season' / 'data'
raw_dir = data_dir / 'raw'
cleaned_dir = data_dir / 'cleaned'
txt_file = raw_dir / 'fantasy_football_stats_2025_OG.txt'

df = read_csv(txt_file)
df.to_csv(cleaned_dir / 'fantasy_football_stats_2025_cleaned.csv', index=False)

# Input the start and end columns for each section to split
# The function will make a new dataframe with just those columns
# Create a new table for the games section
games_table = split_data('Player', 'G', df)
# Export table to csv
games_table.to_csv(cleaned_dir / 'information.csv', index=False)

# Create a new table for the passing section
passing_table = split_data('Cmp', 'Int', df)
# Export table to csv
passing_table.to_csv(cleaned_dir / 'passing.csv', index=False)

# Create a new table for the rushing section
rushing_table = split_data('Att.1', 'TD.1', df)
# Export table to csv
rushing_table.to_csv(cleaned_dir / 'rushing.csv', index=False)

# Create a new table for the receiving section
receiving_table = split_data('Tgt', 'TD.2', df)
# Export table to csv
receiving_table.to_csv(cleaned_dir / 'receiving.csv', index=False)

# Create a new table for the fumbles section
fumbles_table = split_data('Fmb', 'FL', df)
# Export table to csv
fumbles_table.to_csv(cleaned_dir / 'fumbles.csv', index=False)

# Create a new table for the scoring section
scoring_table = split_data('2PM', '2PP', df)
# Export table to csv
scoring_table.to_csv(cleaned_dir / 'scoring.csv', index=False)

# Create a new table for the fantasy section
fantasy_table = split_data('PPR', '', df)
# Export table to csv
fantasy_table.to_csv(cleaned_dir / 'fantasy.csv', index=False)
