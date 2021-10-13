# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Raincloud plot, y = Trust in science, x = Country (DE, UK, US), group = timepoint (T1, T2, T3)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")

# load data
data_trust_in_science <- read_table2("data/trust_in_science.txt")


# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame
data_sci <- data.frame(data_trust_in_science)

# convert risk variable to factor for plotting
data_sci$Timepoint <- factor(data_sci$Timepoint) 
data_sci$Country.1DE_2UK_3US. <- factor(data_sci$Country.1DE_2UK_3US.)

# x positions
x_box_T1 <- 0.175
x_box_T2 <- 0.225
x_box_T3 <- 0.275
x_vio <- -0.175

# colors 
color1 <- 'skyblue'
color2 <- 'dodgerblue1'
color3 <- 'dodgerblue4'


# PLOT -------------------------------------------------------------------------------------------------


fig_sci <- ggplot(data = data_sci, aes(x = Country.1DE_2UK_3US., y = trust_in_science)) +   
  geom_point(aes(color = Timepoint),
             position = position_jitterdodge(jitter.width = 0.225, dodge.width = 0.3, seed = '321'),
             size = 1.5,
             alpha = 0.6) +
  # violin plots per group to specify positions and alpha separately 
  geom_half_violin(data = data_sci %>% filter(Timepoint == 1), 
                   position = position_nudge(x = x_vio),
                   fill = color1,
                   width = 0.5,
                   scale = 'width') +
  geom_half_violin(data = data_sci %>% filter(Timepoint == 2), 
                   position = position_nudge(x = x_vio),
                   fill = color2,
                   width = 0.5,
                   scale = 'width',
                   alpha = 0.6) +
  geom_half_violin(data = data_sci %>% filter(Timepoint == 3), 
                   position = position_nudge(x = x_vio),
                   fill = color3,
                   width = 0.5,
                   alpha = 0.6,
                   scale = 'width') +
  # box plots per group to specify positions and alpha separately 
  geom_half_boxplot(data = data_sci %>% filter(Timepoint == 1), 
                    position = position_nudge(x = x_box_T1),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color1) +
  geom_half_boxplot(data = data_sci %>% filter(Timepoint == 2), 
                    position = position_nudge(x = x_box_T2),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color2,
                    alpha = 0.6) +
  geom_half_boxplot(data = data_sci %>% filter(Timepoint == 3), 
                    position = position_nudge(x = x_box_T3),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color3,
                    alpha = 0.6) + 
 # theme & labels
  scale_x_discrete(labels = c("DE", "UK", "US")) +  
  xlab("") +
  ylab("Trust in science") +
  theme_bw() + 
  theme(panel.grid.major.x = element_blank(),
        legend.position = "none") + 
  scale_fill_manual(values = c(color1, color2, color3)) +
  scale_color_manual(values = c(color1, color2, color3))   

# Show figure
fig_sci



