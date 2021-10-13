# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Raincloud plot, y = Absolute risk perception, x = Risk (Get COVID, Infect others, Severe symptoms),
# group = Country (DE, UK, US)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")


# load data
data_abs_risk_country <- read_table2("data/absolute_risk_perception_country_changedHeader.txt")

# PREPROCESS DATA -------------------------------------------------------------------------------------- 

# make data frame
data_arc <- data.frame(data_abs_risk_country)

# add subject number
sub_n <- length(data_arc[,1])
subj <- 1:sub_n
data_arc <- data.frame(subj, data_arc)

# convert to long format
data_arc <- data_arc %>%
  pivot_longer(
    cols = contains("self"), # columns to pivot into longer format (tidy-select 'contains' to select variables that contain 'self')
    names_to = 'risk',
    values_to = 'response'
  )

# as factor for plotting
data_arc$risk <- factor(data_arc$risk) 
data_arc$country_1.DE_2.UK_3.US <- factor(data_arc$country_1.DE_2.UK_3.US)

# colors 
color1 <- 'dodgerblue4'
color2 <- 'red4'
color3 <- 'darkgoldenrod3'

# boxplot positions 
x_box_de <- 0.175
x_box_uk <- 0.225
x_box_us <- 0.275
x_vio <- -0.175

# PLOT -------------------------------------------------------------------------------------------------


fig_arc <- ggplot(data = data_arc, aes(x = risk, y = response)) +   
  geom_point(aes(color = country_1.DE_2.UK_3.US),
             position = position_jitterdodge(jitter.width = 0.225, dodge.width = 0.3, seed = '321'),
             size = 1.5,
             alpha = 0.6) + 
  geom_half_violin(aes(fill = country_1.DE_2.UK_3.US),
                   position = position_nudge(x_vio),
                   width = 0.5,
                   alpha = 0.6,
                   scale = 'width') +
  # box plots per group to specify positions and alpha separately
  geom_half_boxplot(data = data_arc %>% filter(country_1.DE_2.UK_3.US == 1),
                    position = position_nudge(x_box_de),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = .15,
                    fill = color1) +
  geom_half_boxplot(data = data_arc %>% filter(country_1.DE_2.UK_3.US == 2),
                    position = position_nudge(x_box_uk),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE, 
                    width = .15,
                    fill = color2,
                    alpha = 0.6) +
  geom_half_boxplot(data = data_arc %>% filter(country_1.DE_2.UK_3.US == 3),
                    position = position_nudge(x_box_us),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE, 
                    width = .15,
                    fill = color3,
                    alpha = 0.6) +
  # theme & labels
  scale_x_discrete(labels=c("Get COVID", "Infect others", "Severe symptoms")) + 
  xlab("") +
  ylab("Absolute risk perception") +
  theme_bw()+
  theme(panel.grid.major.x = element_blank(), # remove vertical grid lines       
        legend.position = "none") +    
  scale_fill_manual(values = c(color1, color2, color3)) +
  scale_color_manual(values = c(color1, color2, color3))

# Show figure
fig_arc

