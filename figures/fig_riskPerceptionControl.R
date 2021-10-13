# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Raincloud plot, y = Relative risk perception (self-other), x = Risk (Influenza, Bone fracture, STD)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")


# load data 
data_relative_risk_perception <- read_delim("data/data_optimism_compare.txt", 
                                    "\t", escape_double = FALSE, trim_ws = TRUE)

# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame
data_rp <- data.frame(data_relative_risk_perception)
head(data_rp)

# add subject number
sub_n <- length(data_rp[,1])
subj <- 1:sub_n
data_rp <- data.frame(subj, data_rp)

# convert to long format
data_rp <- data_rp %>%
  pivot_longer(!subj, names_to = 'risk', values_to = 'response')

# change order of factor levels 
data_rp$risk <- factor(data_rp$risk, levels=c("Influenza", "bone_fracture", "STD"))

# colors 
color1 <- 'dodgerblue'

# positions 
x_box <- .15
x_vio <- -.15


# PLOT -------------------------------------------------------------------------------------------------


fig_rp <- ggplot(data = data_rp, aes(x = risk, y = response)) +      
  # add darker gird line at y = 0
  geom_hline(yintercept = 0, color = 'gray55') +
  geom_point(position = position_jitter(width = 0.1, seed = '321'),
             size = 1.5, 
             color = color1,
             alpha = 0.6) +
  geom_half_boxplot(position = position_nudge(x_box),
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
                   scale = 'width') +
  # theme & labels 
  scale_y_continuous(breaks = c(-80, -40, 0, 40, 80), limits = c(-80, 80)) +
  scale_x_discrete(labels = c("Influenza", "Bone fracture", "STD")) +    
  xlab("") +
  ylab("Relative risk perception") +
  theme_bw() +                                         
  theme(panel.grid.major.x = element_blank()) # remove vertical grid lines                                                              


# show figure
fig_rp



