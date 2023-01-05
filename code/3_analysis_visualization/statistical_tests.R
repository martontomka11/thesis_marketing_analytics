# Import dataset
setwd('C:/...') # Set working directory
podcasts_sample_joined <- read.csv("podcasts_sample_joined.csv")
par(mfrow=c(1,1))

# The final models that we test for
linear_model_listenscore <- lm(listen_score ~ broad_targeting*host_google_hits_mln+genre_kids_family+genre_news+genre_comedy+genre_society_culture+genre_government+genre_true_crime+genre_religion_spirituality+genre_technology+publisher_network_dummy+total_episodes+episode_length_min+update_freq_days, podcasts_sample_joined); summary(linear_model_listenscore)
round(summary(linear_model_listenscore)$coefficients, 4)

linear_model_rating <- lm(log(apple_rating) ~ broad_targeting*host_google_hits_mln+genre_kids_family+genre_news+genre_comedy+genre_society_culture+genre_government+genre_true_crime+genre_religion_spirituality+genre_technology+publisher_network_dummy+total_episodes+episode_length_min+update_freq_days, podcasts_sample_joined); summary(linear_model_rating)
round(summary(linear_model_rating)$coefficients, 4)

# Q-Q Plot
plot(linear_model_listenscore, which = 2)
plot(linear_model_rating, which = 2)

# Fitted value vs Residuals plot
plot(linear_model_listenscore, which = 1)
plot(linear_model_rating, which = 1)

## Testing for heteroskedasticity
# Calculate heteroskedasticity-robust standard errors
library(lmtest)
library(sandwich)
coeftest(linear_model_listenscore, vcov = vcovHC(linear_model_listenscore, type = 'HC0'))
coeftest(linear_model_rating, vcov = vcovHC(linear_model_listenscore, type = 'HC0'))

# Breusch-Pagan Test for heteroskedasticity
library(lmtest)
bptest(linear_model_listenscore)
bptest(linear_model_rating)
# H0: Homoscedasticity is present
# H1: Heteroskedasticity is present
# p-value is too high, so we accept H0, Homoscedasticity is fulfilled

# No multicollinearity assumption testing (through VIF, Variance Inflation Factor)
library(car)
vif(linear_model_listenscore)
vif(linear_model_rating) 
# These results show a VIF value above 5 for the interaction term, and for the moderator.
# This is because moderation inherently has collinearity between the variables. 

# Therefore, we calculate the VIF values without the interaction terms
linear_model_listenscore_vif <- lm(listen_score ~ broad_targeting+host_google_hits_mln+genre_kids_family+genre_news+genre_comedy+genre_society_culture+genre_government+genre_true_crime+genre_religion_spirituality+genre_technology+publisher_network_dummy+total_episodes+episode_length_min+update_freq_days, podcasts_sample_joined); summary(linear_model_listenscore_vif)
round(summary(linear_model_listenscore_vif)$coefficients, 4)
vif(linear_model_listenscore_vif)

linear_model_rating_vif <- lm(log(apple_rating) ~ broad_targeting+host_google_hits_mln+genre_kids_family+genre_news+genre_comedy+genre_society_culture+genre_government+genre_true_crime+genre_religion_spirituality+genre_technology+publisher_network_dummy+total_episodes+episode_length_min+update_freq_days, podcasts_sample_joined); summary(linear_model_rating_vif)
round(summary(linear_model_rating_vif)$coefficients, 4)
vif(linear_model_rating_vif) 
# VIF is not above 5, they are all around ~1.1, which is a good sign

## Correlation matrix between predictor variables
correlationmatrix <- podcasts_sample_joined[ , c("broad_targeting", "host_google_hits_mln", "genre_kids_family", "genre_news", "genre_comedy", "genre_society_culture", "genre_government", "genre_true_crime", "genre_religion_spirituality", "genre_technology", "publisher_network_dummy", "total_episodes", "episode_length_min", "update_freq_days")]
cor_matrix <- cor(correlationmatrix)
cor_matrix

# Create correlation heatmap
library(reshape2)
cormat <- round(cor(correlationmatrix),2)

melted_cormat <- melt(cormat)

library(ggplot2)
ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()

# Get lower triangle of the correlation matrix
get_upper_tri<-function(cormat){
  cormat[lower.tri(cormat)] <- NA
  return(cormat)
}

upper_tri <- get_upper_tri(cormat)

# Melt the correlation matrix
library(reshape2)
melted_cormat <- melt(upper_tri, na.rm = TRUE)

# Heatmap
library(ggplot2)
ggplot(data = melted_cormat, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "royalblue3", high = "red2", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  theme_minimal()+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))+
  coord_fixed()

# Heatmap2
reorder_cormat <- function(cormat){
  # Use correlation between variables as distance
  dd <- as.dist((1-cormat)/2)
  hc <- hclust(dd)
  cormat <-cormat[hc$order, hc$order]
}

# Reorder the correlation matrix
# cormat <- reorder_cormat(cormat)
# upper_tri <- get_upper_tri(cormat)

# Melt the correlation matrix
melted_cormat <- melt(upper_tri, na.rm = TRUE)
# Create a ggheatmap
ggheatmap <- ggplot(melted_cormat, aes(Var2, Var1, fill = value))+
  geom_tile(color = "white")+
  scale_fill_gradient2(low = "royalblue3", high = "red2", mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Pearson\nCorrelation") +
  theme_minimal()+ # minimal theme
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))+
  coord_fixed()
# Print the heatmap
print(ggheatmap)

ggheatmap + 
  geom_text(aes(Var2, Var1, label = value), color = "black", size = 3) +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    legend.justification = c(1, 0),
    legend.position = c(0.6, 0.7),
    legend.direction = "horizontal")+
  guides(fill = guide_colorbar(barwidth = 7, barheight = 1,
                               title.position = "top", title.hjust = 0.5))

# Performing the Goldeld-Quandt test for heteroskedasticity
# First, variable transformations are needed: converting genre dummy variables to 0 and 1 coding
library(tidyverse)

podcasts_sample_joined <- mutate(podcasts_sample_joined, genre_kids_family2 = case_when(
  genre_kids_family == "TRUE" ~ 1,
  genre_kids_family == "FALSE" ~ 0))

podcasts_sample_joined <- mutate(podcasts_sample_joined, genre_news2 = case_when(
  genre_news == "TRUE" ~ 1,
  genre_news == "FALSE" ~ 0))

podcasts_sample_joined <- mutate(podcasts_sample_joined, genre_comedy2 = case_when(
  genre_comedy == "TRUE" ~ 1,
  genre_comedy == "FALSE" ~ 0))

podcasts_sample_joined <- mutate(podcasts_sample_joined, genre_society_culture2 = case_when(
  genre_society_culture == "TRUE" ~ 1,
  genre_society_culture == "FALSE" ~ 0))

podcasts_sample_joined <- mutate(podcasts_sample_joined, genre_government2 = case_when(
  genre_government == "TRUE" ~ 1,
  genre_government == "FALSE" ~ 0))

podcasts_sample_joined <- mutate(podcasts_sample_joined, genre_true_crime2 = case_when(
  genre_true_crime == "TRUE" ~ 1,
  genre_true_crime == "FALSE" ~ 0))

podcasts_sample_joined <- mutate(podcasts_sample_joined, genre_religion_spirituality2 = case_when(
  genre_religion_spirituality == "TRUE" ~ 1,
  genre_religion_spirituality == "FALSE" ~ 0))

podcasts_sample_joined <- mutate(podcasts_sample_joined, genre_technology2 = case_when(
  genre_technology == "TRUE" ~ 1,
  genre_technology == "FALSE" ~ 0))

# Goldfeld-Quandt test (variable versions with 1 or 0 were used in the case of dummy explanatory variables)
# We remove about ~20% of the central observations, which in this case is 580*0.2=116
# install.packages("lmtest")
library(lmtest)
gqtest(linear_model_listenscore, order.by = ~broad_targeting2+host_google_hits_mln+publisher_network_dummy2+total_episodes+audio_length_sec+update_frequency_hours, data = podcasts_sample_joined, fraction = 116)
gqtest(linear_model_rating, order.by = ~broad_targeting2+host_google_hits_mln+publisher_network_dummy2+total_episodes+audio_length_sec+update_frequency_hours, data = podcasts_sample_joined, fraction = 116)
# H0: Homoscedasticity is present
# H1: Heteroskedasticity is present
# p-value is too high, so we accept H0, Homoscedasticity is fulfilled

