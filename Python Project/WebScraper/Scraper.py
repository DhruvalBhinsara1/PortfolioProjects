import pandas as pd
import requests
import re
import os

url = 'https://en.wikipedia.org/wiki/List_of_largest_companies_by_revenue'

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36'
}

page = requests.get(url, headers=headers)

tables = pd.read_html(page.text)

table = tables[0]

print(table)

output_path = os.path.join(os.path.dirname(__file__), 'largest_companies_by_revenue.csv')
table.to_csv(output_path, index=False)