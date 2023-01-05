# Import podcasts_hosts file
podcasts_hosts <- read.csv(".../podcasts_hosts.csv") # File location
View(podcasts_hosts)

host_1 <- podcasts_hosts$host_1
host_2 <- podcasts_hosts$host_2
host_3 <- podcasts_hosts$host_3

# Import separate data files
setwd('C:/...') # Working directory
podcasts_sample <- read.csv("podcasts_sample.csv")
View(podcasts_sample)

podcasts_listen_score <- read.csv("podcasts_listen_score.csv")
podcasts_consumer_targeting_dummy <- read.csv("podcasts_consumer_targeting_dummy.csv")
podcasts_publisher_network_dummy <- read.csv("podcasts_publisher_network_dummy.csv")

View(podcasts_listen_score)
View(podcasts_consumer_targeting_dummy)
View(podcasts_publisher_network_dummy)

# Tidyverse is needed to make the joins
library(tidyverse)

# Join podcasts_listen_score into a new dataset podcasts_sample_joined
podcasts_listen_score <- podcasts_listen_score %>%
  select(id, listen_score)

podcasts_sample_joined <- left_join(podcasts_sample, podcasts_listen_score, by = "id")

# Convert listen_score to numeric
podcasts_sample_joined$listen_score <- as.numeric(podcasts_sample_joined$listen_score)

# Join podcasts_consumer_targeting_dummy into podcasts_sample_joined
podcasts_consumer_targeting_dummy <- podcasts_consumer_targeting_dummy %>%
  select(id, consumer_targeting, broad_targeting)

podcasts_sample_joined <- left_join(podcasts_sample_joined, podcasts_consumer_targeting_dummy, by = "id")

# Join podcasts_publisher_network_dummy into podcasts_sample_joined
podcasts_publisher_network_dummy <- podcasts_publisher_network_dummy %>%
  select(id, publisher_network_dummy)

podcasts_sample_joined <- left_join(podcasts_sample_joined, podcasts_publisher_network_dummy, by = "id")

# View joined file
View(podcasts_sample_joined)

# Delete rows with "NA" variables
podcasts_sample_joined <- subset(podcasts_sample_joined, consumer_targeting!="")

# Write new dataset to a CSV file
write_csv(podcasts_sample_joined, "podcasts_sample_joined.csv")

# podcasts_sample_joined <- read.csv("podcasts_sample_joined.csv")
# Join star effect file
podcasts_star_effect <- read.csv("podcasts_star_effect.csv")
podcasts_star_effect <- podcasts_star_effect %>%
  select(id, qscores_star_effect)

podcasts_sample_joined <- left_join(podcasts_sample_joined, podcasts_star_effect, by = "id")

# Join apple ratings file
podcasts_ratings <- read.csv("podcasts_ratings.csv")
podcasts_sample_joined <- left_join(podcasts_sample_joined, podcasts_ratings, by = "itunes_id")

# Filter for observations with more than 50 ratings
podcasts_sample_joined <- podcasts_sample_joined %>% filter(apple_nr_ratings > 49)

# Join google_hits file: adds the google_hits, host_1, host_2 and host_3 variables
podcasts_google_hits <- read.csv("podcasts_google_hits.csv")
library("tidyverse")
podcasts_sample_joined <- left_join(podcasts_sample_joined, podcasts_google_hits, by = "id")

class(podcasts_sample_joined$host_google_hits)
podcasts_sample_joined$host_google_hits <- as.numeric(podcasts_sample_joined$host_google_hits)

# Create new variable, Google hits in thousands
podcasts_sample_joined$host_google_hits_tsd <- podcasts_sample_joined$host_google_hits / 10000

# Create new variable, Google hits in millions
podcasts_sample_joined$host_google_hits_mln <- podcasts_sample_joined$host_google_hits / 1000000




