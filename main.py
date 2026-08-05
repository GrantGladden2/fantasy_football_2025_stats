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

# Create a new table for the passing section
passing_table = split_data('Complete','Int',df)

# Create a new table for the rushing section
rushing_table = split_data('Att','TD',df)

# Create a new table for the receiving section
receiving_table = split_data('Tgt','TD',df)

# Create a new table for the fumbles section
fumbles_table = split_data('Fmb','FL',df)

# Create a new table for the scoring section
scoring_table = split_data('TD','2PP',df)

# Create a new table for the fantasy section
fantasy_table = split_data('PPR','',df)