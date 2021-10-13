# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Rainclout plot, y = Relative risk perception, x = time horizon (2 weeks, 2 months, next year, lifetime)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")


# load data
data_get_covid_rel <- read_table2("data/get_COVID_diff_time_horizon.txt")
head(data_get_covid_rel)


# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame 
data_gcr <- data.frame(data_get_covid_rel)

# add subject number
sub_n <- length(data_gcr[,1])
subj <- 1:sub_n
data_gcr <- data.frame(subj, data_gcr)

# convert to long format
data_gcr <- data_gcr %>%
  pivot_longer(!subj, names_to = 'time', values_to = 'response')

# as factor for plotting
data_gcr$time <- factor(data_gcr$time) 

# change order of factor levels 
data_gcr$time <- factor(data_gcr$time, levels = c("X2_weeks","X2_months","Next_year","Lifetime"))

# colors 
color1 <- 'dodgerblue1'

# positions 
x_box <- .15
x_vio <- -.15


# PLOT -------------------------------------------------------------------------------------------------


fig_gcr <- ggplot(data = data_gcr, aes(x = time, y = response)) + 
  # add darker gird line at y = 0
  geom_hline(yintercept = 0, color = "gray55") +
  geom_point(size = 1.5,
             color = color1,
             alpha = 0.6,
             position = position_jitter(width = 0.1, seed = '321')) +
  geom_half_boxplot(position = position_nudge(x = x_box),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.2,
                    fill = color1,
                    alpha = 0.6) +
  geom_half_violin(position = position_nudge(x = x_vio),
                   fill = color1,
                   alpha = 0.6,
                   width = 0.5,
                   scale = 'width') +
  # theme & labels 
  scale_x_discrete(labels = c('2 weeks','2 months','Next year', 'Lifetime')) +   
  xlab("") +
  ylab("Relative risk perception") +
  theme_bw() +                                           
  theme(panel.grid.major.x = element_blank()) # remove vertical grid lines                                                                     

# show figure
fig_gcr

