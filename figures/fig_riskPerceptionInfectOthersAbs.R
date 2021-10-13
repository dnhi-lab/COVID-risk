# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Raincloud plot, y = Absolute risk perception, x = context (Family, Friends, Colleagues, Recreation, Travel, Public_chores)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")


# load data
data_infect_others_abs <- read_table2("data/infect_others_self_social_contexts.txt")
head(data_infect_others_abs)


# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame 
data_ioa <- data.frame(data_infect_others_abs)

# add subject number
sub_n <- length(data_ioa[,1])
subj <- 1:sub_n
data_ioa <- data.frame(subj, data_ioa)

# convert to long format
data_ioa <- data_ioa %>%
  pivot_longer(!subj, names_to = 'context', values_to = 'response')

# as factor for plotting
data_ioa$context <- factor(data_ioa$context) 

# change order of factor levels 
data_ioa$context <- factor(data_ioa$context, levels = c("Family","Friends","Colleagues","Recreation", "Travel", "Public_chores"))

# colors 
color1 <- 'dodgerblue1'

# positions 
x_box <- .15
x_vio <- -.15


# PLOT -------------------------------------------------------------------------------------------------


fig_ioa <- ggplot(data = data_ioa, aes(x = context, y = response)) + 
  geom_point(position = position_jitter(width = 0.1, seed = '321'),
             size = 1.5,
             color = color1,
             alpha = 0.6) +
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
  scale_x_discrete(labels = c("Family","Friends","Colleagues","Recreation", "Travel", "Public chores")) +   
  xlab("") +
  ylab("Absolute risk perception") +
  theme_bw() +                                           
  theme(panel.grid.major.x = element_blank()) # remove vertical grid lines                                                                     

# show figure
fig_ioa

