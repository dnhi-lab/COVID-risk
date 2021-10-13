# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Boxplot, y = Absolute risk perception, x = Risk (Get COVID, Infect others, Severe symptoms),
# group = overal health (very poor - very good)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")


# load data
data_absolute_risk_perception_health <- read_table2("data/absolute_risk_perception_health.txt")

# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame 
data_arh <- data.frame(data_absolute_risk_perception_health)

# add subject number
sub_n <- length(data_arh[,1])
subj <- 1:sub_n
data_arh <- data.frame(subj, data_arh)

# convert to long format
data_arh <- data_arh %>%
  pivot_longer(
    cols = contains("self"), # columns to pivot into longer format (tidy-select 'contains' to select variables that contain 'self')
    names_to ='risk',
    values_to = 'response'
  )

# as factor for plotting
data_arh$risk <- factor(data_arh$risk) 
data_arh$overall_health <- factor(data_arh$overall_health)

# colors 
allColors <- c('dodgerblue4','dodgerblue3','dodgerblue1','steelblue1','skyblue')


# PLOT ------------------------------------------------------------------------------------------------- 


fig_arh <- ggplot(data = data_arh, aes(x = risk, y= response)) + 
  geom_half_boxplot(aes(fill = overall_health),
                    position = position_dodge(0.55),
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE) +
  # theme & labels 
  scale_x_discrete(labels=c("Get COVID", "Infect others", "Severe symptoms")) +
  xlab("") +
  ylab("Absolute risk perception") +
  theme_bw() + 
  theme(panel.grid.major.x = element_blank(),
        legend.position = "none") + 
  scale_fill_manual(values = allColors) +
  scale_color_manual(values = allColors)

# Show figure
fig_arh

