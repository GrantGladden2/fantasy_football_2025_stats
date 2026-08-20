# Import necessary packages
import pandas as pd


# This function will read in the file and drop the necessary columns
def read_csv(csv_file: str) -> pd.DataFrame:

    # Read the csv file to a dataframe
    df = pd.read_csv(csv_file, header=1)

    # Drop unnecessary columns
    df.drop(columns=['Rk', 'GS', 'TD_tot', 'FantPt', 'DKPt', 'FDPt', 'VBD',
                     'PosRank', 'OvRank'], inplace=True)

    # Clean the other data that needs to be cleaned
    for i in range(len(df)):
        current_player = df.loc[i, 'Player']
        player = current_player.rstrip("*+")
        df.replace(current_player, player, inplace=True)

    # If there is a null value, make it 0
    df.fillna(0, inplace=True)

    return df


# This function will split the data into separate tables to be later queried
def split_data(start_col: str, end_col: str, df: pd.DataFrame) -> pd.DataFrame:
    # If the name of the column does not exist, report back
    if start_col not in df.columns:
        print("That column name does not exist does not exist")

    # If end is blank, assume there's only one column
    if end_col == '':
        table = df[start_col]
        table = pd.concat([table, df['player_id']], axis=1)

    else:
        # Create a new data frame using the table and start
        # and end cols provided
        table = df.loc[:, start_col:end_col]

        if 'player_id' not in table.columns:
            table = pd.concat([table, df['player_id']], axis=1)

    # Clean the new table and return
    table = query_data(table)

    return table


# This function will query the different tables
def query_data(table: pd.DataFrame) -> pd.DataFrame:

    # condition = (~table['Rk'].isnull())
    # table = table[condition]

    # Initiate a drop indeices list
    drop_indices = []

    # Iterate through each row
    for index, row in table.iterrows():
        query_row = row[:-1]

        # Any players with all 0s, remove from the table
        bool_drop = all(stat == 0 for stat in query_row)
        if bool_drop:
            drop_indices.append(index)

    table = table.drop(drop_indices)

    return table
