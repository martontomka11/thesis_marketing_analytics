# Import dataset
setwd('C:/...') # Set working directory
podcasts_sample_joined <- read.csv("podcasts_sample_joined.csv")

# Summarize variables in the dataset
summary(podcasts_sample_joined) 

# Summary table for metric and categorical variables was created in Word
# Summary table for genre tags was created in Excel

# Box and whiskers plot: Broad vs Niche - ListenScore
library(ggplot2)
# Store the graph
box_plot <- ggplot(podcasts_sample_joined, aes(x = broad_targeting, y = listen_score))
# Add the geometric object box plot
box_plot +
  geom_boxplot()

# Box and whiskers plot: Broad vs Niche - Apple Ratings
library(ggplot2)
# Store the graph
box_plot2 <- ggplot(podcasts_sample_joined, aes(x = broad_targeting, y = apple_rating))
# Add the geometric object box plot
box_plot2 +
  geom_boxplot()

# Create histogram of numeric variable distributions
ListenScore <- podcasts_sample_joined$listen_score
hist(ListenScore)
AppleRating <- podcasts_sample_joined$apple_rating
hist(AppleRating)
AppleNrRatings <- podcasts_sample_joined$apple_nr_ratings
hist(AppleNrRatings, xlim = c(0, 50000))
HostGoogleHits <- podcasts_sample_joined$host_google_hits_mln
hist(HostGoogleHits)
NrMainGenre <- podcasts_sample_joined$nr_main_genres
hist(NrMainGenre, breaks = 7)
NrGenre <- podcasts_sample_joined$nr_genres
hist(NrGenre)
TotalEpisodes <- podcasts_sample_joined$total_episodes
hist(TotalEpisodes, xlim = c(0, 4000))
AudioLength <- podcasts_sample_joined$episode_length_min
hist(AudioLength)
UpdateFrequency <- podcasts_sample_joined$update_freq_days
hist(UpdateFrequency)

attach(mtcars)
par(mfrow=c(3,3))
hist(ListenScore, main="ListenScore")
hist(AppleRating, main="Apple Avg Rating")
hist(AppleNrRatings, main="Nr of Apple Ratings")
hist(HostGoogleHits, main="Host Google hits (mln)")
hist(NrMainGenre, main="Nr of Main Genres", breaks = 7)
hist(NrGenre, main="Nr of Genres")
hist(TotalEpisodes, main="Nr of Total Episodes", xlim = c(0, 4000))
hist(AudioLength, main="Avg Episode Length (min)")
hist(UpdateFrequency, main="Avg Update Frequency (days)")




