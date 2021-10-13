# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Raincloud plot, y = Relative risk perception, x = Risk (Get COVID, Infect others, Severe symptoms),
# group = Gender (female, male)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")

# load data
data_rel_risk_gender <- read_table2("data/relative_risk_perception_gender.txt")


# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame
data_rrg <- data.frame(data_rel_risk_gender)

# add subject number
sub_n <- length(data_rrg[,1])
subj <- 1:sub_n
data_rrg <- data.frame(subj, data_rrg)

# convert to long format
data_rrg <- data_rrg %>%
  pivot_longer(
    cols = contains("diff"), # columns to pivot into longer format - use tidy-select 'contains' to select variables that contain 'diff'
    names_to = 'risk',
    values_to = 'response'
  )

# as factor for plotting
data_rrg$risk <- factor(data_rrg$risk) 
data_rrg$gender.0.f_1.m. <- factor(data_rrg$gender.0.f_1.m.)

# delete rows with gender = 3
data_rrg_2 <- data_rrg[!(data_rrg$gender.0.f_1.m.==2),]

# x positions
x_box_f <- 0.175
x_box_m <- 0.225
x_vio <- -0.175

# colors
color1 <- 'red'
color2 <- 'dodgerblue'


# PLOT -------------------------------------------------------------------------------------------------


fig_rrg <- ggplot(data = data_rrg_2, aes(x = risk, y = response)) +   
  # add darker gird line at y = 0
  geom_hline(yintercept = 0, color = 'gray55')+
  geom_point(aes(color = gender.0.f_1.m.),
             position = position_jitterdodge(jitter.width = 0.3, dodge.width = 0.3, seed = '321'),
             size = 1.5,
             alpha = 0.6) + 
  # violin plots per group to specify positions and alpha separately 
  geom_half_violin(data = data_rrg_2 %>% filter(gender.0.f_1.m. == 0),
                   position = position_nudge(x_vio),
                   width = 0.5,
                   fill = color1,
                   scale = 'width') +
  geom_half_violin(data = data_rrg_2 %>% filter(gender.0.f_1.m. == 1),
                   position = position_nudge(x_vio),
                   width = 0.5,
                   fill = color2,
                   alpha = 0.6,
                   scale = 'width') +
  # box plots per group to specify positions and alpha separately 
  geom_half_boxplot(data = data_rrg_2 %>% filter(gender.0.f_1.m. == 0),
                    position = position_nudge(x = x_box_f),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color1) +
  geom_half_boxplot(data = data_rrg_2 %>% filter(gender.0.f_1.m. == 1),
                    position = position_nudge(x = x_box_m),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color2,
                    alpha = 0.6,) +
  # theme & labels 
  scale_x_discrete(labels = c("Get COVID", "Infect others", "Severe symptoms")) + 
  scale_y_continuous(breaks = c(-80, -40, 0,40, 80), limits = c(-80,80)) +
  xlab("") +
  ylab("Relative risk perception") +
  theme_bw() + 
  theme(panel.grid.major.x = element_blank(),
        legend.position = 'none') +  
  scale_fill_manual(values = c(color1, color2)) +
  scale_color_manual(values = c(color1, color2))

# Show figure
fig_rrg

