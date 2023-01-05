/code/1_data_collection/api/ListenNotes_API_Extractor_general.ipynb:
This is the script used to extract information about 20 podcast shows each query, from the 'Best Podcasts' section of the ListenNotes website. Following extraction, the files are organized in a table format, and parsed to a CSV file. An API key from ListenNotes is required to run each query. The lines that have to be changed each query are marked with hashtags. A total of 52 CSV files are generated, each containing data for a maximum of 20 podcast shows as observations.

/code/1_data_collection/api/ListenNotes_API_Extractor_by_genre.ipynb:
This is the script used to extract information about 20 podcast shows each query, from a specific genre section of the ListenNotes website. Following extraction, the files are organized in a table format, and parsed to a CSV file. An API key from ListenNotes is required to run each query. The lines that have to be changed each query are marked with hashtags. A total of 203 CSV files are generated, each containing data for a maximum of 20 podcast shows as observations.

/code/1_data_collection/web_scraper/Apple_Podcasts_Scraper.ipynb:
This script is used to extract the ratings and number of ratings variables for each podcast show in the sample, from the Apple Podcasts website. The scraper loops through each row of the 'podcasts_apple_ratings_itunes.csv' file using the 'iTunes ID' variable, adds the ID to the URL, thus creating the individual URL for each observation. Afterwards, the scraper loops through 50 lines, and collects the variables for each podcast show. 12 queries are needed to extract data for 600 podcasts. The lines that have to be changed each query are marked with hashtags. A total of 12 CSV files are generated, which contain the ratings data for all 600 observations in the sample.

/code/2_data_preparation/1_importing_cleaning_data.R:
This script is used to import and merge the data files that were collected through the ListenNotes API. The name of the resulting dataset is 'podcasts_dataset'. Next, data cleaning and filtering is conducted to only include variables and observations that are necessary and in the right format for analysis.

/code/2_data_preparation/2_sampling.R:
Following the importing and cleaning process, a random sample of 600 podcast shows is drawn from the 'podcasts_dataset', without replacements. Afterwards, the script writes separate CSV files files that are necessary for the manual data collection process.

/code/2_data_preparation/3_create_publisher_network_variable.R:
The publisher network dummy variable shows whether a podcast network or studio was involved in the creation of a podcast. This script shows the process of creating this variable for some of the observations. At the end of the script, a separate CSV file is written to complete this variable for the remaining observations through manual data collection.

/code/2_data_preparation/4_clean_apple_ratings.R:
This script is used to merge together the CSV files that were collected using the Apple Podcasts web scraper. The dataset created is named 'podcasts_ratings'. Data cleaning and formatting is also performed to prepare the 'ratings' and 'number of ratings' variables for analysis.

/code/2_data_preparation/5_join_files.R:
All separate CSV files are merged using this script, to create the final 'podcasts_sample_joined' dataset. The dataset is filtered to only include podcasts with at least 50 ratings. The final dataset consists of 580 observations.

/code/2_data_preparation/6_create_genre_dummy_variables.R:
A total of 21 main genre categories are available on ListenNotes. In the 'podcasts_sample_joined' dataset, an observation has at least one genre tag, but may also have several. This script transforms the 'Genre ID' variable and matches the genre codes with their respective genres. Finally, dummy variables are created for all 21 main genre categories, showing which genre tags are relevant for each observation. After this step, the 'podcasts_sample_joined' dataset is complete, and ready for analysis.

/code/3_analysis_visualization/variable_testing.R: 
The goal of the variable sanity checks is to make sure that the variables in the dataset accurately represent the variables in the conceptual model. This script performs calculations and creates visualizations to support the use of the most important variables in the study: ListenScore, Apple Ratings, Consumer targeting method (Niche/Broad), and the star-effect (Google hits).

/code/3_analysis_visualization/summary_statistics.R:
This script calculates summary statistics and creates plots (histogram, box and whiskers plot) regarding the most important metric and categorical variables included in the study.

/code/3_analysis_visualization/statistical_tests.R:
To prove that the statistical assumptions for the linear regression model are met, this script calculates tests (such as the Breusch-Pagan Test for heteroskedasticity) and creates visualizations (such as the Fitted value vs Residuals plot).

/code/3_analysis_visualization/main_regression_models.R:
This script is used to run both of the final multivariate linear regression models, including all explanatory variables, as well as the interaction term between niche/broad targeting and the star-effect. Afterwards, the results are summarized in an estimates table.

/code/3_analysis_visualization/additional_regression_models.R:
This script contains code for the additional linear regression models that were run to provide robustness for the results.

