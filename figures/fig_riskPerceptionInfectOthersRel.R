# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Raincloud plot, y = Relative risk perception, x = context (Family, Friends, Colleagues, Recreation, Travel, Public_chores)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")


# load data
data_infect_others_rel <- read_table2("data/infect_others_diff_social_contexts.txt")
head(data_infect_others_rel)


# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame 
data_ior <- data.frame(data_infect_others_rel)

# add subject number
sub_n <- length(data_ior[,1])
subj <- 1:sub_n
data_ior <- data.frame(subj, data_ior)

# convert to long format
data_ior <- data_ior %>%
  pivot_longer(!subj, names_to = 'context', values_to = 'response')

# as factor for plotting
data_ior$context <- factor(data_ior$context) 

# change order of factor levels 
data_ior$context <- factor(data_ior$context, levels = c("Family","Friends","Colleagues","Recreation", "Travel", "Public_chores"))

# colors 
color1 <- 'dodgerblue1'

# positions 
x_box <- .15
x_vio <- -.15


# PLOT -------------------------------------------------------------------------------------------------


fig_ior <- ggplot(data = data_ior, aes(x = context, y = response)) + 
  # add darker gird line at y = 0
  geom_hline(yintercept = 0, color = 'gray55') +
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
  scale_x_discrete(labels = c("Family","Friends","Colleagues","Recreation", "Travel", "Public chores")) +   #
  xlab("") +
  ylab("Relative risk perception") +
  theme_bw() +                                           
  theme(panel.grid.major.x = element_blank()) # remove vertical grid lines                                                                 

# show figure
fig_ior

