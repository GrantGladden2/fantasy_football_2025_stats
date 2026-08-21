# Import necessary packages
import pandas as pd


# This function will read in the file and drop the necessary columns
def read_csv(txt_file: str) -> pd.DataFrame:

    # Read the txt file to a dataframe
    df = pd.read_csv(txt_file, header=1)
    print(df.columns)

    # Drop unnecessary columns
    df.drop(columns=['Rk', 'GS', 'FantPt', 'DKPt', 'FDPt', 'VBD',
                     'PosRank', 'OvRank'], inplace=True)

    # Clean the other data that needs to be cleaned
    # Strip any weird characters from the names
    for i in range(len(df)):
        current_player = df.loc[i, 'Player']
        player = current_player.rstrip("*+")
        df.replace(current_player, player, inplace=True)

    # If there is a null value, make it 0
    df.fillna(0, inplace=True)

    # Keep only the first occurrence of each player_id, drop later duplicates
    df = df.drop_duplicates(subset="-9999", keep="first")

    return df


# This function will split the data into separate tables to be later queried
def split_data(start_col: str, end_col: str, df: pd.DataFrame) -> pd.DataFrame:
    # If the name of the column does not exist, report back
    if start_col not in df.columns:
        print("That column name does not exist does not exist")

    # If end is blank, assume there's only one column
    if end_col == '':
        table = df[start_col]
        id_col = df[['-9999']].rename(columns={'-9999': 'player_id'})
        table = pd.concat([table, id_col], axis=1)

    else:
        # Create a new data frame using the table and start
        # and end cols provided
        table = df.loc[:, start_col:end_col]

        if '-9999' not in table.columns:
            id_col = df[['-9999']].rename(columns={'-9999': 'player_id'})
            table = pd.concat([table, id_col], axis=1)

    return table
