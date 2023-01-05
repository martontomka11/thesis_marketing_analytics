# Create overall ratings file
setwd('.../data') # Working directory

library(tidyverse)

# Merge together all 12 separate CSV files collected through the web scraper
podcasts_ratings <-
  list.files(path = ".../data", pattern = "*.csv") %>% # Working directory
  map_df(~read_csv(.))
View(podcasts_ratings)

# Delete rows with "NA" variables
podcasts_ratings <- subset(podcasts_ratings, itunes_id!="NA")

# Remove the " Ratings" string from the apple_nr_ratings column
podcasts_ratings$apple_nr_ratings <- gsub(' Ratings','',podcasts_ratings$apple_nr_ratings)
new_str <- gsub('[AntonApt]','',address_str)

# Convert apple_nr_ratings column to regular numbers format
podcasts_ratings$is_K <- grepl("K", podcasts_ratings$apple_nr_ratings)
podcasts_ratings$apple_nr_ratings_2 <- as.numeric(gsub("K", "", podcasts_ratings$apple_nr_ratings)) * ifelse(podcasts_ratings$is_K, 1000, 1)

# Delete two columns
podcasts_ratings$apple_nr_ratings <- NULL
podcasts_ratings$is_K <- NULL

# Rename apple_nr_ratings_2
colnames(podcasts_ratings) <- c("itunes_id", "apple_rating", "apple_nr_ratings")

# Write .csv to file
write_csv(podcasts_ratings, "podcasts_ratings.csv")
