# Main function for fantasy football 2025 season stats
# Import packages as needed
from data_query import *

# Input csv file name and use the function to create the pandas dataframe
csv_file = 'fantasy_football_stats_2025.csv'
df = read_csv(csv_file)

# Input the start and end columns for each section to split
# The function will make a new dataframe with just those columns


# Create a new table for the games section
games_table = split_data('Player','Games',df)
print(games_table)
# Export table to csv
# games_table.to_csv('games.csv', index=False)

# Create a new table for the passing section
passing_table = split_data('Complete','Int',df)
print(passing_table)
# Export table to csv
# passing_table.to_csv('passing.csv', index=False)

# Create a new table for the rushing section
rushing_table = split_data('Att','TD.2',df)
print(rushing_table)

# Export table to csv
# rushing_table.to_csv('rushing.csv', index=False)

# Create a new table for the receiving section
receiving_table = split_data('Tgt','TD.3',df)
# Export table to csv
# receiving_table.to_csv('receiving.csv', index=False)

# Create a new table for the fumbles section
fumbles_table = split_data('Fmb','FL',df)
# Export table to csv
# fumbles_table.to_csv('fumbles.csv', index=False)

# Create a new table for the scoring section
scoring_table = split_data('2PM','2PP',df)
# Export table to csv
# scoring_table.to_csv('scoring.csv', index=False)

# Create a new table for the fantasy section
fantasy_table = split_data('PPR','',df)
# Export table to csv
# fantasy_table.to_csv('fantasy.csv', index=False)