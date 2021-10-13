# Figures for paper 'Risk perception and optimism bias during the early stages of the COVID-19 pandemic'
# Raincloud plot, y = Relative risk perception, x = Risk (Get COVID, Infect others, Severe symptoms),
# group = Country (DE, UK, US)


# libraries  
library("readr")  
library('tidyr')    
library("dplyr")
library("ggplot2")
library("gghalves")


# Load data
data_rel_risk_country <- read_table2("data/relative_risk_perception_country_changedHeader.txt")

# PREPROCESS DATA --------------------------------------------------------------------------------------

# make data frame
data_rrc <- data.frame(data_rel_risk_country)

# add subject number
sub_n <- length(data_rrc[,1])
subj <- 1:sub_n
data_rrc <- data.frame(subj, data_rrc)

# convert to long format
data_rrc <- data_rrc %>%
  pivot_longer(
    cols = contains("diff"),    
    names_to = 'risk',
    values_to = 'response'
  )

# as factor for plotting
data_rrc$risk <- factor(data_rrc$risk) 
data_rrc$country_1.DE_2.UK_3.US <- factor(data_rrc$country_1.DE_2.UK_3.US)

# boxplot positions 
x_box_de <- 0.175
x_box_uk <- 0.225
x_box_us <- 0.275
x_vio <- -0.175

# colors 
color1 <- 'dodgerblue4'
color2 <- 'red4'
color3 <- 'darkgoldenrod3'

# PLOT -------------------------------------------------------------------------------------------------


fig_rrc <- ggplot(data = data_rrc, aes(x = risk, y = response)) + 
  # add darker gird line at y = 0
  geom_hline(yintercept = 0, color = 'gray55') +   
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
  geom_half_boxplot(data = data_rrc %>% filter(country_1.DE_2.UK_3.US == 1),
                    position = position_nudge(x = x_box_de),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color1) +
  geom_half_boxplot(data = data_rrc %>% filter(country_1.DE_2.UK_3.US == 2),
                    position = position_nudge(x = x_box_uk),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color2,
                    alpha = 0.6) +
  geom_half_boxplot(data = data_rrc %>% filter(country_1.DE_2.UK_3.US == 3),
                    position = position_nudge(x = x_box_us),
                    side = "r",
                    outlier.shape = NA,
                    center = TRUE,
                    errorbar.draw = FALSE,
                    width = 0.15,
                    fill = color3,
                    alpha = 0.6) +
  # theme & labels 
  scale_x_discrete(labels = c("Get COVID", "Infect others", "Severe symptoms")) + 
  scale_y_continuous(breaks = c(-80, -40, 0,40, 80), limits = c(-80,80)) +
  xlab("") +
  ylab("Relative risk perception") +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(), # remove vertical grid lines         
        legend.position = "none") + 
  scale_fill_manual(values = c(color1, color2, color3)) +
  scale_color_manual(values = c(color1, color2, color3))

# Show figure
fig_rrc


