# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Boxplot, y = Relative risk perception, x = Risk (Get COVID, Infect others, Severe symptoms),
# group = overal health (very poor - very good)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")

# load data 
data_relative_risk_perception_health <- read_table2("data/relative_risk_perception_health.txt")

# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame 
data_rrh <- data.frame(data_relative_risk_perception_health)

# add subject number
sub_n <- length(data_rrh[,1])
subj <- 1:sub_n
data_rrh <- data.frame(subj, data_rrh)

# convert to long format
data_rrh <- data_rrh %>%
  pivot_longer(
    cols = contains("diff"), # columns to pivot into longer format (tidy-select 'contains' to select variables that contain 'diff')
    names_to='risk',
    values_to = 'response'
  )

# as factor for plotting
data_rrh$risk <- factor(data_rrh$risk) 
data_rrh$overall_health <- factor(data_rrh$overall_health)

# colors 
allColors <- c('dodgerblue4','dodgerblue3','dodgerblue1','steelblue1','skyblue')

# PLOT -------------------------------------------------------------------------------------------------


fig_rrh <- ggplot(data = data_rrh, aes(x = risk, y = response)) + 
  # add darker gird line at y = 0
  geom_hline(yintercept = 0, color = 'gray55') +
  geom_half_boxplot(aes(fill = overall_health),
                    position = position_dodge(0.55),
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,) +
  # theme & labels 
  scale_x_discrete(labels = c("Get COVID", "Infect others", "Severe symptoms")) + 
  scale_y_continuous(breaks = c(-80, -40, 0, 40, 80), limits = c(-80,80)) +
  xlab("") +
  ylab("Relative risk perception") +
  theme_bw() +                       
  theme(panel.grid.major.x = element_blank(),
        legend.position = "none") + 
  scale_fill_manual(values = allColors) +
  scale_color_manual(values = allColors)

# Show figure
fig_rrh



