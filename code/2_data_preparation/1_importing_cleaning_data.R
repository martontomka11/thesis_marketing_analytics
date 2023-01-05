# Set working directory
setwd('C:/...') # Directory on computer

# Remove scientific notation
options(scipen=999)

# Import files collected with the API, and combine them into one dataset
library(tidyverse)

podcasts <-
  list.files(path = ".../data", pattern = "*.csv") %>% # Directory on computer
  map_df(~read_csv(.))
View(podcasts)

# Alternative code to import and combine files
# library(dplyr)
# library(readr)
# podcasts <- list.files(path="C:/Users/tomka/OneDrive/Desktop/Tilburg_University/Thesis/Data_Cleaning_R/Data_Cleaning_2/data", full.names = TRUE) %>% 
#  lapply(read_csv) %>% 
#  bind_rows 

# Write 'podcasts' dataset to CSV file
write_csv(podcasts, "data/podcasts.csv")

# Delete rows with "NA" variables
podcasts <- subset(podcasts, id!="NA")

# Delete duplicate rows based on 'id'
podcasts <- podcasts %>% distinct(id, .keep_all = TRUE)

# Print all digits for all variables
options(digits=22)

# Convert milliseconds to date format for 'earliest_pub_date_ms' and 'latest_pub_date_ms' variables
# UTC + 0.00 timezone is used
ms_to_date = function(ms, t0="1970-01-01", timezone) {
  sec = ms / 1000
  as.POSIXct(sec, origin=t0, tz=timezone)
}

podcasts$earliest_pub_date <- ms_to_date(podcasts$earliest_pub_date_ms, timezone="Europe/London")
podcasts$latest_pub_date <- ms_to_date(podcasts$latest_pub_date_ms, timezone="Europe/London")

# Filter for podcast shows that are active (latest episode within the last 3 months)
podcasts <- podcasts %>% filter(latest_pub_date > '2022-07-06')

# Filter for podcast shows that have been active since at least 2 years
podcasts <- podcasts %>% filter(earliest_pub_date < '2020-10-06')

# Filter for podcast shows with at least 50 episodes
podcasts <- podcasts %>% filter(total_episodes > 49)

# Filter for English language podcast shows
podcasts <- podcasts %>% filter(language == 'English')

# Filter for podcast shows based in the United States
podcasts <- podcasts %>% filter(country == 'United States')

# Delete unavailable variables (ListenNotes API PRO version is needed for these):
podcasts$listen_score <- NULL
podcasts$listen_score_global_rank <- NULL
podcasts$rss <- NULL
podcasts$latest_episode_id <- NULL
podcasts$extra <- NULL
podcasts$email <- NULL

# Delete looking_for variable
podcasts$looking_for <- NULL

# Delete date variables that are in ms (milliseconds) format
podcasts$earliest_pub_date_ms <- NULL
podcasts$latest_pub_date_ms <- NULL

# Export total dataset to CSV file
write_csv(podcasts, "podcasts_dataset.csv")




