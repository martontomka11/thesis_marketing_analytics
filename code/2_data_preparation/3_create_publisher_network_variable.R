# Necessary libraries
library(tidyverse)
library(stringr)

### Determine most frequent publisher companies in the dataset ###
# (using the entire dataset, not just the sample one)
podcasts_dataset <- read.csv("podcasts_dataset.csv")
podcasts_sample <- read.csv("podcasts_sample.csv")
View(podcasts_dataset)
summary(podcasts_dataset)

# Frequency of all publishers
table(podcasts_dataset$publisher)

# The most common publisher
names(which.max(table(podcasts_dataset$publisher)))

# The 150 most common publishers:
sort(table(podcasts_dataset$publisher),decreasing=TRUE)[1:150]

# All publishers with more than 2 podcast shows
sort(table(podcasts_dataset$publisher),decreasing=TRUE)[1:57]
# Manual sanity checks of the results
# Check all results with fewer than 4 occurrences
# Verified podcast networks/studios/publishers: iHeartPodcasts, NPR, Barstool Sports, PodcastOne, Slate Podcasts, Wondery, Blaze Podcast Network, Headgum, The Ringer, Crooked Media, Kinda Funny, That Sounds Fun Network, Ascension, Pushkin Industries, 
# ..., The New York Times, All Things Comedy, Cloud10 and iHeartPodcasts, Dear Media, Exactly Right, Focus on the Family, Relay FM, Vox Media Podcast Network, American Public Media, audiochuck, Cumulus Podcast Network, Gen-Z Media | Wondery, iHeartPodcasts and Grim & Mild, Kast Media, 
# ..., MaximumFun.org, Nashville Podcast Network, QuickAndDirtyTips.com, Starburns Audio, The Daily Wire, TWiT, BiggerPockets, Bloody FM, Bloomberg, Cadence13, CBS News Radio, Evergreen Podcasts, Fool and Scholar Productions, Freakonomics Radio + Stitcher, IGN, Jomboy Media, KCRW,
# ..., Ligonier Ministries, Loud Speakers Network, MeatEater, NFL, Podcast Nation, PodcastOne / Carolla Digital, The Athletic, The Economist, Vox, WBUR      
# Occurred on the list, but not verified: Fantasy Football, Joyce Meyer

# Create publisher_network_dummy dataset
publisher_network_dummy <- podcasts_sample[,c("id","title", "publisher", "listennotes_url", "website")]

# Full outer join the 'host_1', 'host_2', and 'host_3' variables from the podcast_hosts dataset
podcast_hosts <- read.csv("data_collection/podcasts_hosts.csv")
podcast_hosts$title <- NULL
podcast_hosts$publisher <- NULL
podcast_hosts$description <- NULL
podcast_hosts$listennotes_url <- NULL
View(podcast_hosts)

publisher_network_dummy <- full_join(publisher_network_dummy, podcast_hosts, by='id')
View(publisher_network_dummy)  

# Create new publisher_network_dummy variable
publisher_network_dummy$publisher_network_dummy <- NA

# Set the publisher_network_dummy variable to FALSE for podcast shows where the one of the hosts' name is equal to the publishers' name
publisher_network_dummy$publisher_network_dummy[publisher_network_dummy$publisher == publisher_network_dummy$host_1] <- 'FALSE'
publisher_network_dummy$publisher_network_dummy[publisher_network_dummy$publisher == publisher_network_dummy$host_2] <- 'FALSE'
publisher_network_dummy$publisher_network_dummy[publisher_network_dummy$publisher == publisher_network_dummy$host_3] <- 'FALSE'

# Set the publisher_network_dummy variable to FALSE for podcast shows where the title is equal to the publishers' name
publisher_network_dummy$publisher_network_dummy[publisher_network_dummy$publisher == publisher_network_dummy$title] <- 'FALSE'

# Set the publisher_network_dummy variable to TRUE for podcast shows where the publisher includes the word "Network"   
publisher_network_dummy$publisher_network_dummy[str_detect(publisher_network_dummy$publisher, fixed("Network"))] <- 'TRUE'

# Set the publisher_network_dummy variable to TRUE for podcast shows where the publisher includes the word "Studio"
publisher_network_dummy$publisher_network_dummy[str_detect(publisher_network_dummy$publisher, fixed("Studio"))] <- 'TRUE'

# Set the publisher_network_dummy variable to TRUE for podcast shows with the above publisher values
publisher_network_dummy$publisher_network_dummy[publisher_network_dummy$publisher=="iHeartPodcasts"|publisher_network_dummy$publisher=="NPR"|publisher_network_dummy$publisher=="Barstool Sports"|publisher_network_dummy$publisher=="PodcastOne"|publisher_network_dummy$publisher=="Slate Podcasts"|publisher_network_dummy$publisher=="Wondery"|
                                                  publisher_network_dummy$publisher=="Blaze Podcast Network"|publisher_network_dummy$publisher=="Headgum"|publisher_network_dummy$publisher=="The Ringer"|publisher_network_dummy$publisher=="Crooked Media"|publisher_network_dummy$publisher=="Kinda Funny"|publisher_network_dummy$publisher=="That Sounds Fun Network"|
                                                  publisher_network_dummy$publisher=="Ascension"|publisher_network_dummy$publisher=="Pushkin Industries"|publisher_network_dummy$publisher=="The New York Times"|publisher_network_dummy$publisher=="All Things Comedy"|publisher_network_dummy$publisher=="Cloud10 and iHeartPodcasts"|publisher_network_dummy$publisher=="Dear Media"|
                                                  publisher_network_dummy$publisher=="Exactly Right"|publisher_network_dummy$publisher=="Focus on the Family"|publisher_network_dummy$publisher=="Relay FM"|publisher_network_dummy$publisher=="Vox Media Podcast Network"|publisher_network_dummy$publisher=="American Public Media"|publisher_network_dummy$publisher=="audiochuck"|
                                                  publisher_network_dummy$publisher=="Cumulus Podcast Network"|publisher_network_dummy$publisher=="Gen-Z Media | Wondery"|publisher_network_dummy$publisher=="iHeartPodcasts and Grim & Mild"|publisher_network_dummy$publisher=="Kast Media"|publisher_network_dummy$publisher=="MaximumFun.org"|publisher_network_dummy$publisher=="Nashville Podcast Network"|
                                                  publisher_network_dummy$publisher=="QuickAndDirtyTips.com"|publisher_network_dummy$publisher=="Starburns Audio"|publisher_network_dummy$publisher=="The Daily Wire"|publisher_network_dummy$publisher=="TWiT"|publisher_network_dummy$publisher=="BiggerPockets"|publisher_network_dummy$publisher=="Bloody FM"|
                                                  publisher_network_dummy$publisher=="Bloomberg"|publisher_network_dummy$publisher=="Cadence13"|publisher_network_dummy$publisher=="CBS News Radio"|publisher_network_dummy$publisher=="Evergreen Podcasts"|publisher_network_dummy$publisher=="Fool and Scholar Productions"|publisher_network_dummy$publisher=="Freakonomics Radio + Stitcher"|
                                                  publisher_network_dummy$publisher=="IGN"|publisher_network_dummy$publisher=="Jomboy Media"|publisher_network_dummy$publisher=="KCRW"|publisher_network_dummy$publisher=="Ligonier Ministries"|publisher_network_dummy$publisher=="Loud Speakers Network"|publisher_network_dummy$publisher=="MeatEater"|
                                                  publisher_network_dummy$publisher=="NFL"|publisher_network_dummy$publisher=="Podcast Nation"|publisher_network_dummy$publisher=="PodcastOne / Carolla Digital"|publisher_network_dummy$publisher=="The Athletic"|publisher_network_dummy$publisher=="The Economist"|publisher_network_dummy$publisher=="Vox"|
                                                  publisher_network_dummy$publisher=="WBUR"] <- 'TRUE'

# publisher_network_dummy$publisher_network_dummy <- ifelse(publisher_network_dummy$publisher=="iHeartPodcasts"|publisher_network_dummy$publisher=="NPR"|publisher_network_dummy$publisher=="Barstool Sports"|publisher_network_dummy$publisher=="PodcastOne"|publisher_network_dummy$publisher=="Slate Podcasts"|publisher_network_dummy$publisher=="Wondery"|
#                                                          publisher_network_dummy$publisher=="Blaze Podcast Network"|publisher_network_dummy$publisher=="Headgum"|publisher_network_dummy$publisher=="The Ringer"|publisher_network_dummy$publisher=="Crooked Media"|publisher_network_dummy$publisher=="Kinda Funny"|publisher_network_dummy$publisher=="That Sounds Fun Network"|
#                                                          publisher_network_dummy$publisher=="Ascension"|publisher_network_dummy$publisher=="Pushkin Industries"|publisher_network_dummy$publisher=="The New York Times"|publisher_network_dummy$publisher=="All Things Comedy"|publisher_network_dummy$publisher=="Cloud10 and iHeartPodcasts"|publisher_network_dummy$publisher=="Dear Media"|
#                                                          publisher_network_dummy$publisher=="Exactly Right"|publisher_network_dummy$publisher=="Focus on the Family"|publisher_network_dummy$publisher=="Relay FM"|publisher_network_dummy$publisher=="Vox Media Podcast Network"|publisher_network_dummy$publisher=="American Public Media"|publisher_network_dummy$publisher=="audiochuck"|
#                                                          publisher_network_dummy$publisher=="Cumulus Podcast Network"|publisher_network_dummy$publisher=="Gen-Z Media | Wondery"|publisher_network_dummy$publisher=="iHeartPodcasts and Grim & Mild"|publisher_network_dummy$publisher=="Kast Media"|publisher_network_dummy$publisher=="MaximumFun.org"|publisher_network_dummy$publisher=="Nashville Podcast Network"|
#                                                          publisher_network_dummy$publisher=="QuickAndDirtyTips.com"|publisher_network_dummy$publisher=="Starburns Audio"|publisher_network_dummy$publisher=="The Daily Wire"|publisher_network_dummy$publisher=="TWiT"|publisher_network_dummy$publisher=="BiggerPockets"|publisher_network_dummy$publisher=="Bloody FM"|
#                                                          publisher_network_dummy$publisher=="Bloomberg"|publisher_network_dummy$publisher=="Cadence13"|publisher_network_dummy$publisher=="CBS News Radio"|publisher_network_dummy$publisher=="Evergreen Podcasts"|publisher_network_dummy$publisher=="Fool and Scholar Productions"|publisher_network_dummy$publisher=="Freakonomics Radio + Stitcher"|
#                                                          publisher_network_dummy$publisher=="IGN"|publisher_network_dummy$publisher=="Jomboy Media"|publisher_network_dummy$publisher=="KCRW"|publisher_network_dummy$publisher=="Ligonier Ministries"|publisher_network_dummy$publisher=="Loud Speakers Network"|publisher_network_dummy$publisher=="MeatEater"|
#                                                          publisher_network_dummy$publisher=="NFL"|publisher_network_dummy$publisher=="Podcast Nation"|publisher_network_dummy$publisher=="PodcastOne / Carolla Digital"|publisher_network_dummy$publisher=="The Athletic"|publisher_network_dummy$publisher=="The Economist"|publisher_network_dummy$publisher=="Vox"|
#                                                          publisher_network_dummy$publisher=="WBUR",
#                                                         'TRUE', NA)

# Export publisher_network_dummy dataset to CSV file, for further data collection process
write_csv(publisher_network_dummy, "data_collection/podcasts_publisher_network_dummy.csv")
