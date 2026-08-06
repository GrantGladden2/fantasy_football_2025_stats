# Import necessary packages
import pandas as pd
import sqlite3

# This function will read in the file and drop the necessary columns
def read_csv(csv_file):

    # Read the csv file to a dataframe
    df = pd.read_csv(csv_file, header=1)

    # Drop unnecessary columns
    df.drop(columns=['Rk','Games Started','FantPt','DKPt','FDPt','VBD','PosRank','OvRank'],inplace=True)

    # Clean the other data that needs to be cleaned
    for i in range(len(df)):
        current_player = df.loc[i, 'Player']
        player = current_player.rstrip("*+")
        df.replace(current_player,player,inplace=True)

    return df

# This function will split the data into separate tables to be later queried
def split_data(start_col,end_col,df):
    # If the name of the column does not exist, report back
    if start_col not in df.columns:
        print("That column name does not exist does not exist")

    # If end is blank, assume there's only one column
    if  end_col == '':
        table = df[start_col]

        # Clean the new table and return
        table = query_data(table)
        return table

    # Create a new data frame using the table and start and end cols provided
    table = df.loc[:, start_col:end_col]

    # Clean the new table and return
    table = query_data(table)
    return table

# This function will query the different tables
def query_data(table):

    # Any players with all 0s, remove from the table


    return table