# Set-up working file
setwd('C:/...') # Working directory
podcasts_sample_joined <- read.csv("podcasts_sample_joined.csv")
View(podcasts_sample_joined)

### Create dummy variables for genres ###
# Delete commas and parentheses from the genre_ids variable
library(tidyverse) # the stringr package from the tidyverse is needed
podcasts_sample_joined$genre_ids_clean <- gsub(",","",podcasts_sample_joined$genre_ids)
podcasts_sample_joined$genre_ids_clean <- gsub("]","",podcasts_sample_joined$genre_ids_clean)
podcasts_sample_joined$genre_ids_clean <- str_sub(podcasts_sample_joined$genre_ids_clean, 2)

## Create individual variables for genre tags, by pairing the respective number codes (using grepl)
# Personal Finance genre variable
podcasts_sample_joined$genre_personal_finance <- case_when(grepl("144", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_personal_finance[is.na(podcasts_sample_joined$genre_personal_finance)] <- FALSE  

# Locally Focused genre variable
podcasts_sample_joined$genre_locally_focused <- case_when(grepl("151", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_locally_focused[is.na(podcasts_sample_joined$genre_locally_focused)] <- FALSE  

# Sports genre variable
podcasts_sample_joined$genre_sports <- case_when(grepl("77", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_sports[is.na(podcasts_sample_joined$genre_sports)] <- FALSE  

# Business genre variable
podcasts_sample_joined$genre_business <- case_when(grepl("93", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_business[is.na(podcasts_sample_joined$genre_business)] <- FALSE  

# Health & Fitness genre variable
podcasts_sample_joined$genre_health_fitness <- case_when(grepl("88", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_health_fitness[is.na(podcasts_sample_joined$genre_health_fitness)] <- FALSE  

# Music genre variable
podcasts_sample_joined$genre_music <- case_when(grepl("134", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_music[is.na(podcasts_sample_joined$genre_music)] <- FALSE  

# Technology genre variable
podcasts_sample_joined$genre_technology <- case_when(grepl("127", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_technology[is.na(podcasts_sample_joined$genre_technology)] <- FALSE  

# Fiction genre variable
podcasts_sample_joined$genre_fiction <- case_when(grepl("168", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_fiction[is.na(podcasts_sample_joined$genre_fiction)] <- FALSE  

# History genre variable
podcasts_sample_joined$genre_history <- case_when(grepl("125", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_history[is.na(podcasts_sample_joined$genre_history)] <- FALSE  

# Kids & Family genre variable
podcasts_sample_joined$genre_kids_family <- case_when(grepl("132", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_kids_family[is.na(podcasts_sample_joined$genre_kids_family)] <- FALSE  

# News genre variable
podcasts_sample_joined$genre_news <- case_when(grepl("99", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_news[is.na(podcasts_sample_joined$genre_news)] <- FALSE  

# Comedy genre variable
podcasts_sample_joined$genre_comedy <- case_when(grepl("133", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_comedy[is.na(podcasts_sample_joined$genre_comedy)] <- FALSE  

# Society & Culture genre variable
podcasts_sample_joined$genre_society_culture <- case_when(grepl("122", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_society_culture[is.na(podcasts_sample_joined$genre_society_culture)] <- FALSE  

# Religion & Spirituality genre variable
podcasts_sample_joined$genre_religion_spirituality <- case_when(grepl("69", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_religion_spirituality [is.na(podcasts_sample_joined$genre_religion_spirituality)] <- FALSE  

# Government genre variable
podcasts_sample_joined$genre_government <- case_when(grepl("117", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_government[is.na(podcasts_sample_joined$genre_government)] <- FALSE  

# TV & Film variable (we have to allocate FALSE to columns containing 168 and not 68, as that is representing another genre, fiction)
podcasts_sample_joined$genre_tvfilm <- case_when(grepl("68", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_tvfilm[is.na(podcasts_sample_joined$genre_tvfilm)] <- FALSE 

podcasts_sample_joined$genre_tvfilm[podcasts_sample_joined$genre_personal_fiction == TRUE] <- FALSE
podcasts_sample_joined$genre_tvfilm[podcasts_sample_joined$genre_ids_clean == "68 67 185 168 266"] <- TRUE
podcasts_sample_joined$genre_tvfilm[podcasts_sample_joined$genre_ids_clean == "67 68 168 185 122"] <- TRUE
podcasts_sample_joined$genre_tvfilm[podcasts_sample_joined$genre_ids_clean == "135 104 111 68 125 122 100 67 165 168 102"] <- TRUE
podcasts_sample_joined$genre_tvfilm[podcasts_sample_joined$genre_ids_clean == "168 104 68 132 165 167 67 100 101 133 146 122 166 135"] <- TRUE
podcasts_sample_joined$genre_tvfilm[podcasts_sample_joined$genre_ids_clean == "168 133 165 68 83 67 82"] <- TRUE

# Leisure genre variable
podcasts_sample_joined$genre_leisure <- case_when(grepl("82", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_leisure[is.na(podcasts_sample_joined$genre_leisure)] <- FALSE  

# Education genre variable
podcasts_sample_joined$genre_education <- case_when(grepl("111", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_education[is.na(podcasts_sample_joined$genre_education)] <- FALSE  

# Arts genre variable
podcasts_sample_joined$genre_arts <- case_when(grepl("100", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_arts[is.na(podcasts_sample_joined$genre_arts)] <- FALSE  

# Science genre variable
podcasts_sample_joined$genre_science <- case_when(grepl("107", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_science[is.na(podcasts_sample_joined$genre_science)] <- FALSE  

# True crime genre variable
podcasts_sample_joined$genre_true_crime <- case_when(grepl("135", podcasts_sample_joined$genre_ids_clean) ~ TRUE)
podcasts_sample_joined$genre_true_crime[is.na(podcasts_sample_joined$genre_true_crime)] <- FALSE  

## Create nr of genres variable
podcasts_sample_joined$nr_genres <- lengths(strsplit(podcasts_sample_joined$genre_ids_clean, "\\W+"))

## Create nr of main genres variable
# Paste together all genre variables
podcasts_sample_joined$genre_all <- paste(podcasts_sample_joined$genre_personal_finance,podcasts_sample_joined$genre_locally_focused,podcasts_sample_joined$genre_sports,podcasts_sample_joined$genre_business,podcasts_sample_joined$genre_health_fitness,podcasts_sample_joined$genre_music,podcasts_sample_joined$genre_technology,
                                          podcasts_sample_joined$genre_fiction,podcasts_sample_joined$genre_history,podcasts_sample_joined$genre_kids_family,podcasts_sample_joined$genre_news,podcasts_sample_joined$genre_comedy,podcasts_sample_joined$genre_society_culture,podcasts_sample_joined$genre_religion_spirituality,
                                          podcasts_sample_joined$genre_government,podcasts_sample_joined$genre_tvfilm,podcasts_sample_joined$genre_leisure,podcasts_sample_joined$genre_education,podcasts_sample_joined$genre_arts,podcasts_sample_joined$genre_science,podcasts_sample_joined$genre_true_crime,sep=" ")

# Count "TRUE" variables in genre_all variable
library(stringr)
podcasts_sample_joined$nr_main_genres <- str_count(podcasts_sample_joined$genre_all, "TRUE")

### Create final file
# Write final joined file to csv: this is the final dataset
write_csv(podcasts_sample_joined, "podcasts_sample_joined.csv")

# Within Excel, manual organization of the column sequence was performed, to add a more intuitive look to the dataset


