# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Raincloud plot, y = How much did they do to prevent infection,
# x = Who (Government, Local authorities, Employer, Friends & Family, Self)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")


# load data
data_how_much_did_do <- read_table2("data/how_much_did_do.txt")

# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame
data_hm <- data.frame(data_how_much_did_do)

# add subject number
sub_n <- length(data_hm[,1])
subj <- 1:sub_n
data_hm <- data.frame(subj, data_hm)

# convert to long format
data_hm <- data_hm %>%
  pivot_longer(!subj, names_to = 'who', values_to = 'response')

# as factor for plotting
data_hm$who <- factor(data_hm$who) 

# change order of factor levels 
data_hm$who <- factor(data_hm$who, levels = c("Government","Local_authorities","Employer","Friends_family","Self"))

# colors 
color1 <- 'dodgerblue'

# positions 
x_box <- .15
x_vio <- -.15

# PLOT -------------------------------------------------------------------------------------------------


fig_hm <- ggplot(data = data_hm, aes(x = who, y = response)) +  
  # add darker gird line at y = 0
  geom_hline(yintercept = 0, color = 'gray55') +
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
                   scale = 'width')+
  # theme & labels 
  scale_x_discrete(labels=c("Government", "Local authorities", "Employer", "Friends & Family", "Self" )) +
  xlab("") +
  ylab("How much did they do to prevent infection") +
  theme_bw() +                                           
  theme(panel.grid.major.x = element_blank()) # remove vertical grid lines                                                                     

fig_hm


