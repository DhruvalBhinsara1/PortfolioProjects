# Amazon Mobile Phone WebScraper

A Python-based web scraper for extracting product information from Amazon India mobile phone product pages. This project demonstrates web scraping techniques using BeautifulSoup and requests libraries.

## Overview

This scraper extracts key product information including title, price, rating, features, and specifications from Amazon product URLs. The data is saved to a CSV file for further analysis.

## Features

- Extracts product title, price, rating, features, and specifications
- Handles multiple fallback selectors for robust data extraction
- Implements rate limiting to respect server resources
- Saves scraped data to CSV format
- Includes error handling for failed requests

## Requirements

- Python 3.x
- pandas
- requests
- beautifulsoup4

## Installation

1. Clone or download this repository
2. Install required packages:

   ```bash
   pip install pandas requests beautifulsoup4
   ```

## Usage

1. Open the `Amazon WebScraper.ipynb` notebook
2. Update the `urls` list with the Amazon mobile phone product URLs you want to scrape
3. Run the notebook cells in order
4. The scraped data will be saved to `AmazonWebScraperDataset.csv`

## Data Output

The scraper generates a CSV file with the following columns:

- Title
- Price
- Rating
- Features
- Additional specification columns (varies by product)

## Important Notes

- This scraper is for educational purposes only
- Respect Amazon's terms of service and robots.txt
- Uses appropriate headers to mimic a real browser
- Implements rate limiting (1-second delay between requests) to avoid overwhelming the server

## Key Takeaways

- Web scraping ethics and best practices
- Robust HTML parsing with BeautifulSoup
- Data cleaning and export techniques
- Error handling in web scraping applications

## License

This project is for educational purposes. Please ensure compliance with Amazon's terms of service when using this code.
