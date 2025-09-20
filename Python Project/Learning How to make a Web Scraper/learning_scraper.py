from bs4 import  BeautifulSoup
import requests

url = 'https://www.scrapethissite.com/pages/forms/'

page = requests.get(url)
soup = BeautifulSoup(page.text ,features='lxml')

all_divs = soup.find('p' , class_ = 'lead').text.strip()

all_divs = soup.find('th').text.strip()

print(all_divs)


