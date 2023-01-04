/code/1_data_collection/api/ListenNotes_API_Extractor_general.ipynb:
This is the script used to extract information about 20 podcast shows each query, from the 'Best Podcasts' section of the ListenNotes website. Following extraction, the files are organized in a table format, and parsed to a CSV file. An API key from ListenNotes is required to run each query. The lines that have to be changed each query are marked with hastags.

/code/1_data_collection/api/ListenNotes_API_Extractor_by_genre.ipynb:
This is the script used to extract information about 20 podcast shows each query, from a specific genre section of the ListenNotes website. Following extraction, the files are organized in a table format, and parsed to a CSV file. An API key from ListenNotes is required to run each query. The lines that have to be changed each query are marked with hashtags.

/code/1_data_collection/web_scraper/Apple_Podcasts_Scraper.ipynb:
This script is used to extract the ratings and number of ratings variables for each podcast show in the sample, from the Apple Podcasts website. The scraper loops through each row of a csv file with an iTunes ID variable, adds the ID to the URL, thus creating the individual URL for each observation. Afterwards, the scraper loops through 50 lines, and collects the variables for each podcast show. 12 queries were needed to extract data for 600 podcasts. The lines that have to be changed each query are marked with hashtags.



