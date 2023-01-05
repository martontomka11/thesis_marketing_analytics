/code/1_data_collection/api/ListenNotes_API_Extractor_general.ipynb:
This is the script used to extract information about 20 podcast shows each query, from the 'Best Podcasts' section of the ListenNotes website. Following extraction, the files are organized in a table format, and parsed to a CSV file. An API key from ListenNotes is required to run each query. The lines that have to be changed each query are marked with hastags.

/code/1_data_collection/api/ListenNotes_API_Extractor_by_genre.ipynb:
This is the script used to extract information about 20 podcast shows each query, from a specific genre section of the ListenNotes website. Following extraction, the files are organized in a table format, and parsed to a CSV file. An API key from ListenNotes is required to run each query. The lines that have to be changed each query are marked with hashtags.

/code/1_data_collection/web_scraper/Apple_Podcasts_Scraper.ipynb:
This script is used to extract the ratings and number of ratings variables for each podcast show in the sample, from the Apple Podcasts website. The scraper loops through each row of a csv file with an iTunes ID variable, adds the ID to the URL, thus creating the individual URL for each observation. Afterwards, the scraper loops through 50 lines, and collects the variables for each podcast show. 12 queries were needed to extract data for 600 podcasts. The lines that have to be changed each query are marked with hashtags.

/code/2_data_preparation/1_importing_cleaning_data.R:
This script is used to import and merge the data files that were collected through the ListenNotes API. Next, data cleaning and filtering is conducted to only include variables and observations are necessary and in the right format for analysis.

/code/2_data_preparation/2_sampling.R:
Following the importing and cleaning process, a random sample of 600 podcast shows is drawn, without replacements. Afterwards, the script writes separate CSV files files that are necessary for the manual data collection process.

/code/2_data_preparation/3_create_publisher_network_variable.R:
The publisher network dummy variable shows whether a podcast network or studio was involved in the creation of a podcast. This script shows the process of identifying this variable for some of the observations. At the end of the script, a separate CSV file is written to collect this variable for the remaining variables through manual data collection.

/code/2_data_preparation/4_clean_apple_ratings.R:
This script is used to merge together the CSV files that were collected using the Apple Podcasts web scraper. Data cleaning and formatting is also performed to prepare the 'ratings' and 'number of ratings' variables for analysis.

/code/2_data_preparation/5_join_files.R:
The separate CSV files are merged using this script, to create the final 'podcasts_sample_joined' dataset. The dataset is filtered to only include podcasts with at least 50 ratings. The final dataset consists of 580 observations.

/code/2_data_preparation/6_create_genre_dummy_variables.R:
A total of 21 main genre categories are available on ListenNotes. An observation has at least one genre tag, but may also have several. This script transforms the 'Genre ID' variable and matches the genre codes with their respective genres. Finally, dummy variables are created for all 21 main genre categories, showing which genre tags are relevant for each observation.

/code/3_analysis_visualization/variable_testing.R:

/code/3_analysis_visualization/summary_statistics.R:



/code/3_analysis_visualization/statistical_tests.R:

/code/3_analysis_visualization/main_regression_models.R:

/code/3_analysis_visualization/additional_regression_models.R:

