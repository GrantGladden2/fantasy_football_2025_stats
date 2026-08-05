# Import necessary packages
import pandas as pd
import sqlite3

# This function will split the data in the csv into separate tables to be later queried
def split_tables(csv_file):

    # Read the csv file to a dataframe
    df = pd.read_csv(csv_file, header=1)
    df.drop(columns=['Rk','Games Started','FantPt','DKPt','FDPt','VBD','PosRank','OvRank'],inplace=True)

    return df