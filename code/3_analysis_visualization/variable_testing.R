# Import dataset
setwd('C:/...') # Set working directory
podcasts_sample_joined <- read.csv("podcasts_sample_joined.csv")

# Correlation test between ListenScore and Apple Podcasts nr of ratings
cor(podcasts_sample_joined$listen_score, podcasts_sample_joined$apple_nr_ratings, method = c("kendall"))
cor(podcasts_sample_joined$listen_score, podcasts_sample_joined$apple_nr_ratings, method = c("spearman"))
cor(podcasts_sample_joined$listen_score, podcasts_sample_joined$apple_nr_ratings, method = c("pearson"))

# Scatter plot between ListenScore and Apple Podcasts nr of ratings
library(ggplot2)
ggplot(podcasts_sample_joined, aes(x=listen_score, y=log(apple_nr_ratings))) + geom_point() + geom_jitter() + geom_smooth(method=lm)

## Create confusion matrix
# Top 151 based on nr_main_genres set to TRUE, rest to false
hist(podcasts_sample_joined$nr_main_genres)
class(podcasts_sample_joined$nr_main_genres)
podcasts_sample_joined$nr_main_genres <- as.numeric(podcasts_sample_joined$nr_main_genres)

table(podcasts_sample_joined['nr_main_genres'])
table(podcasts_sample_joined['nr_genres'])

# Create broad_targeting_based_on_nr_main_genres variable (TRUE: top 199 shows, all above or equal to 3 genres)
podcasts_sample_joined$broad_targeting_based_on_nr_main_genres <- ifelse(podcasts_sample_joined$nr_main_genres > 2, TRUE, FALSE)

# Create broad_targeting_based_on_nr_genres variable (TRUE: top 140 shows, all above or equal to 6 genres)
podcasts_sample_joined$broad_targeting_based_on_nr_genres <- ifelse(podcasts_sample_joined$nr_genres > 5, TRUE, FALSE)

# Confusion Matrix
library(caret)
confusionMatrix(table(podcasts_sample_joined$broad_targeting_based_on_nr_genres, podcasts_sample_joined$broad_targeting)) 
confusionMatrix(table(podcasts_sample_joined$broad_targeting_based_on_nr_main_genres, podcasts_sample_joined$broad_targeting)) 
confusionMatrix(table(podcasts_sample_joined$broad_targeting_based_on_nr_genres, podcasts_sample_joined$broad_targeting_based_on_nr_main_genres)) 

# Apple-ratings variable
library(tidyverse)

set.seed(seed = 12948)
podcasts_apple_ratings_check <- podcasts_sample_joined[sample(nrow(podcasts_sample_joined), size = 50, replace = FALSE), ]

write_csv(podcasts_apple_ratings_check, "podcasts_apple_ratings_check.csv")

podcasts_apple_ratings_check <- read.csv("podcasts_apple_ratings_check.csv")

# Correlations, after excluding one outlier
# ("pearson", "kendall", "spearman"))
cor(podcasts_apple_ratings_check$apple_rating, podcasts_apple_ratings_check$spotify_rating, method = c("pearson"))
cor(podcasts_apple_ratings_check$apple_rating, podcasts_apple_ratings_check$spotify_rating, method = c("kendall"))
cor(podcasts_apple_ratings_check$apple_rating, podcasts_apple_ratings_check$spotify_rating, method = c("spearman"))

# Scatter plot: correlation
ggplot(podcasts_apple_ratings_check, aes(x=apple_rating,y=spotify_rating))+geom_jitter()

