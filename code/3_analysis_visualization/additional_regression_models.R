# Import dataset
setwd('C:/...') # Set working directory
podcasts_sample_joined <- read.csv("podcasts_sample_joined.csv")

# Linear model for genre effect on ListenScore
linear_model_genres_listen_score <- lm(listen_score ~ genre_personal_finance + genre_locally_focused + genre_sports + genre_business + genre_health_fitness + genre_music + genre_technology + genre_fiction +
                                         genre_history + genre_kids_family + genre_news + genre_comedy + genre_society_culture + genre_religion_spirituality + genre_government + genre_tvfilm +
                                         genre_leisure + genre_education + genre_arts + genre_science + genre_true_crime,
                                       podcasts_sample_joined); summary(linear_model_genres_listen_score)
round(summary(linear_model_genres_listen_score)$coefficients, 4)

# Linear model for genre effect on Apple Podcasts Rating
linear_model_genres_rating <- lm(apple_rating ~ genre_personal_finance + genre_locally_focused + genre_sports + genre_business + genre_health_fitness + genre_music + genre_technology + genre_fiction +
                                   genre_history + genre_kids_family + genre_news + genre_comedy + genre_society_culture + genre_religion_spirituality + genre_government + genre_tvfilm +
                                   genre_leisure + genre_education + genre_arts + genre_science + genre_true_crime,
                                 podcasts_sample_joined); summary(linear_model_genres_rating)
round(summary(linear_model_genres_rating)$coefficients, 4)

# Creating the summary table
library(pscl)
library(sjPlot)
library(sjmisc)
library(sjlabelled)

tab_model(
  linear_model_genres_listen_score, linear_model_genres_rating, 
  pred.labels = c("Intercept", "Personal Finance", "Locally Focused", "Sports", "Business", "Health & Fitness", "Music", "Technology", "Fiction",
                  "History", "Kids & Family", "News", "Comedy", "Society & Culture", "Religion & Spirituality", "Government", "TV & Film",
                  "Leisure", "Education", "Arts", "Science", "True Crime"),
  dv.labels = c("Prel. model 1: ListenScore", "Prel. model 2: Apple ratings"),
  string.pred = "Coefficient",
  string.ci = "Conf. Int (95%)",
  string.p = "P-Value",
  p.style = "stars",
  digits = 4,
  digits.p = 4,
  digits.re = 4
)

# Linear models using only the independent variable
linear_model_1 <- lm(listen_score ~ broad_targeting, podcasts_sample_joined); summary(linear_model_1)
linear_model_2 <- lm(apple_rating ~ broad_targeting, podcasts_sample_joined); summary(linear_model_2)

# Model 2, with Apple Rating not as log()
linear_model_rating_prel <- lm(apple_rating ~ broad_targeting*host_google_hits_mln+genre_kids_family+genre_news+genre_comedy+genre_society_culture+genre_government+genre_true_crime+genre_religion_spirituality+genre_technology+publisher_network_dummy+total_episodes+episode_length_min+update_freq_days, podcasts_sample_joined); summary(linear_model_rating_prel)
round(summary(linear_model_rating_prel)$coefficients, 4)

# Explicit content regressions
linear_model_1 <- lm(apple_rating ~ explicit_content, podcasts_sample_joined); summary(linear_model_1)
linear_model_2 <- lm(listen_score ~ explicit_content, podcasts_sample_joined); summary(linear_model_2)
