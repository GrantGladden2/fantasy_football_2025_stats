# This function should take in the ESPN website of data
# and transform it into a html file
import requests
from bs4 import BeautifulSoup


def web_to_table(website_link):

    # Read in the website link to a variable
    response = requests.get(website_link)

    # Create the text file from the requested link
    html = BeautifulSoup(response.content, 'html.parser')

    # Find the table of stats
    table = html.find('table', class_="stats")

    # Parse through the table to find each header
    header_row = table.find('thead').find_all('tr', class_='header')[1]

    # Initialize the header list
    headers = []

    # Loop through the html language to find the headers of the table
    for th in header_row.find_all('th'):
        headers.append(th.get("data-id"))

    # Parse through the html body of the table
    stats_row = table.find('tbody').find_all('td')

    # Initialize the lists
    stats = []
    current_player = []
    i = 0

    # Loop through each item in the stats list
    for td in stats_row:
        current_player.append(td.get_text())
        i += 1

        # If the list gets to the same length as the header list,
        # create a new list
        if i == len(headers):
            stats.append(current_player)
            current_player = []
            i = 0
            continue

    return headers, stats
