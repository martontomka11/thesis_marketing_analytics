# Import dataset
setwd('C:/...') # Set working directory
podcasts_sample_joined <- read.csv("podcasts_sample_joined.csv")

# Linear models using only the independent variable
linear_model_1 <- lm(listen_score ~ broad_targeting, podcasts_sample_joined); summary(linear_model_1)
linear_model_2 <- lm(apple_rating ~ broad_targeting, podcasts_sample_joined); summary(linear_model_2)

# Final regression models
linear_model_listenscore <- lm(listen_score ~ broad_targeting*host_google_hits_mln+genre_kids_family+genre_news+genre_comedy+genre_society_culture+genre_government+genre_true_crime+genre_religion_spirituality+genre_technology+publisher_network_dummy+total_episodes+episode_length_min+update_freq_days, podcasts_sample_joined); summary(linear_model_listenscore)
round(summary(linear_model_listenscore)$coefficients, 4)

linear_model_rating <- lm(log(apple_rating) ~ broad_targeting*host_google_hits_mln+genre_kids_family+genre_news+genre_comedy+genre_society_culture+genre_government+genre_true_crime+genre_religion_spirituality+genre_technology+publisher_network_dummy+total_episodes+episode_length_min+update_freq_days, podcasts_sample_joined); summary(linear_model_rating)
round(summary(linear_model_rating)$coefficients, 4)

# Summarize results in estimates table, with confidence intervals
install.packages("sjPlot")
install.packages("sjmisc")
install.packages("sjlabelled")
library(pscl)
library(sjPlot)
library(sjmisc)
library(sjlabelled)

# Both models together
tab_model(
  linear_model_listenscore, linear_model_rating, 
  pred.labels = c("Intercept", "Broad Consumer Targeting: TRUE", "Host Google hits", "Kids & Family genre", "News genre", "Comedy genre", "Society & Culture genre", "Government genre",
                  "True Crime genre", "Religion & Spirituality genre", "Technology genre", "Publisher network: TRUE",
                  "Total episodes", "Avg. audio length (in minutes)", "Avg. update frequency (in days)", "Broad Targeting * Host Google hits"),
  dv.labels = c("Model 1: ListenScore", "Model 2: log(Apple ratings)"),
  string.pred = "Coefficient",
  string.ci = "Conf. Int (95%)",
  string.p = "P-Value",
  p.style = "stars",
  digits = 4,
  digits.p = 4,
  digits.re = 4
)

## Check if R recognizes TRUE/FALSE values in regression models
# Changing dummy variables to 0 and 1
podcasts_sample_joined <- mutate(podcasts_sample_joined, broad_targeting2 = case_when(
  broad_targeting == "TRUE" ~ 1,
  broad_targeting == "FALSE" ~ 0))

podcasts_sample_joined <- mutate(podcasts_sample_joined, publisher_network_dummy2 = case_when(
  publisher_network_dummy == "TRUE" ~ 1,
  publisher_network_dummy == "FALSE" ~ 0))

podcasts_sample_joined <- mutate(podcasts_sample_joined, qscores_star_effect2 = case_when(
  qscores_star_effect == "TRUE" ~ 1,
  qscores_star_effect == "FALSE" ~ 0))

linear_model_listenscore_num <- lm(listen_score ~ broad_targeting2+qscores_star_effect2+publisher_network_dummy2+total_episodes+audio_length_sec+update_frequency_hours, podcasts_sample_joined); summary(linear_model_listenscore_num)
linear_model_rating_num <- lm(apple_rating ~ broad_targeting2+qscores_star_effect2+publisher_network_dummy2+total_episodes+audio_length_sec+update_frequency_hours, podcasts_sample_joined); summary(linear_model_rating_num)
# No differences! Meaning that R recognizes these values

