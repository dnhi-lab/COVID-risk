# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Raincloud plot, y = Absolute risk perception, x = Risk (Get COVID, Infect others, Severe symptoms),
# group = timepoint (T1, T2, T3)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")

# load data
data_abs_risk_timepoint <- read_table2("data/absolute_risk_perception_timepoint_changed_header.txt")


# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame
data_art <- data.frame(data_abs_risk_timepoint)

# add subject number
sub_n <- length(data_art[,1])
subj <- 1:sub_n
data_art <- data.frame(subj, data_art)

# convert to long format
data_art <- data_art %>%
  pivot_longer(
    cols = contains("self"),  # columns to pivot into longer format (tidy-select 'contains' to select variables that contain 'self')
    names_to = 'risk',
    values_to = 'response'
  )

# as factor for plotting
data_art$risk <- factor(data_art$risk) 
data_art$time_point.1.3. <- factor(data_art$time_point.1.3.)

# x positions
x_box_1 <- 0.175
x_box_2 <- 0.225
x_box_3 <- 0.275
x_vio <- -0.175

# colors
color1 <- 'skyblue'
color2 <- 'dodgerblue1'
color3 <- 'dodgerblue4'

# PLOT -------------------------------------------------------------------------------------------------


fig_art <- ggplot(data = data_art, aes(x = risk, y = response)) +
  geom_point(aes(color = time_point.1.3.),
             position = position_jitterdodge(jitter.width = 0.225, dodge.width = 0.3, seed = '321'),
             size = 1.5,
             alpha = 0.6) +
  # violin plots per group to specify positions and alpha separately 
  geom_half_violin(data = data_art %>% filter(time_point.1.3. == 1),
                   position = position_nudge(x_vio),
                   width = 0.5,
                   scale = 'width',
                   fill = color1) +
  geom_half_violin(data = data_art %>% filter(time_point.1.3. == 2),
                   position = position_nudge(x_vio),
                   width = 0.5,
                   alpha = 0.6,
                   scale = 'width',
                   fill = color2) +
  geom_half_violin(data = data_art %>% filter(time_point.1.3. == 3),
                   position = position_nudge(x_vio),
                   width = 0.5,
                   alpha = 0.6,
                   scale = 'width',
                   fill = color3) +
  # box plots per group to specify positions and alpha separately 
  geom_half_boxplot(data = data_art %>% filter(time_point.1.3. == 1),
                    position = position_nudge(x = x_box_1),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color1) +
  geom_half_boxplot(data = data_art %>% filter(time_point.1.3. == 2),
                    position = position_nudge(x = x_box_2),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color2,
                    alpha = 0.6) +
  geom_half_boxplot(data = data_art %>% filter(time_point.1.3. == 3),
                    position = position_nudge(x = x_box_3),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color3,
                    alpha = 0.6) +
  # theme & labels
  scale_x_discrete(labels=c("Get COVID", "Infect others", "Severe symptoms"),) + 
  xlab("") +
  ylab("Absolute risk perception") +
  theme_bw() +                                        
  theme(panel.grid.major.x = element_blank(),
        legend.position = "none") + 
  scale_fill_manual(values = c(color1, color2, color3)) +
  scale_color_manual(values = c(color1, color2, color3))

# Show figure
fig_art



