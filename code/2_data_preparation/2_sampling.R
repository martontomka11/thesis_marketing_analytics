# Tidyverse is needed to read and write csv files
library(tidyverse)

# Import previous dataset (if needed)
podcasts_dataset <- read.csv("podcasts_dataset.csv")

# Sampling (collect 600 random podcasts, without replacement)
set.seed(seed = 12948)
podcasts_sample <- podcasts[sample(nrow(podcasts), size = 600, replace = FALSE), ]
View(podcasts_sample)                                

# Export total dataset to CSV file
write_csv(podcasts_sample, "podcasts_sample.csv")

# Export files needed for further data collection process
write.csv(podcasts_sample[,c("id","title","publisher","listennotes_url")], file="data_collection/podcasts_listen_score.csv",row.names=FALSE)
write.csv(podcasts_sample[,c("id","title","publisher","description","listennotes_url","website","genre_ids")], file="data_collection/podcasts_consumer_targeting_dummy.csv",row.names=FALSE)
write.csv(podcasts_sample[,c("id","title","publisher","itunes_id")], file="data_collection/podcasts_apple_ratings_itunes.csv",row.names=FALSE) # This is the file to run the web scraper with, to collect Apple ratings from the Apple Podcasts website
write.csv(podcasts_sample[,c("id","title","publisher","description","listennotes_url")], file="data_collection/podcasts_hosts.csv",row.names=FALSE)
write.csv(podcasts_sample[,c("id","title", "listennotes_url")], file="data_collection/podcasts_star_effect.csv",row.names=FALSE)



