# Session 6
# 15 March 2023

# Advanced data visualization

# Objectives:
# customizing and formatting figures with theme
# using multiple geoms 
# multi-panel plots
# adding regression lines to figures
# formatting legends
# exporting figures


# ----- Packages -----
# I use tidyverse packages consistently, so I prefer to use the tidyverse package
# which is a bulk load containing the following packages:
# ggplot2, purr, tibble, dplyr, tidyr, stringr, readr, forcats

# Version 1 (lines 25-31) are for bulk load
# Version 2 (lines 34-42) contains code for individual package upload

# please choose 1.


# if you haven't used these packages before, run the following line of code
install.packages("tidyverse")
install.packages("lubridate")

# load packages into R
library(tidyverse)
library(lubridate)


# alternative to loading all of tidyverse
install.packages("dplyr")
install.packages("lubridate")
install.packages("ggplot2")

#load packages in R
library(dplyr)
library(lubridate)
library(ggplot2)


# ----- Load Data ------
temperature <- read.csv("./data/CHONE121_tanktemperature.csv") # water temperature

LW <- read.csv("./data/CHONE121_codlengthweight.csv") # length and weight data


# ----- Format and summarise data -----

data1 <- temperature |> 
  dplyr::mutate( Date = ymd(paste(year, month, day, sep = "-" ))) |> # format date
  dplyr::group_by(Date) |> # group data by date
  dplyr::summarise(Temp.C = mean(temperature), TempSD = sd(temperature)) # calculate daily temperature across all tanks


data2 <- LW |> 
  mutate( Date = ymd( paste(year, month, day, sep = "-")), # format date
          day.of.year = yday(Date)) |> # day of year
  mutate(day.of.year = replace(day.of.year, day.of.year >= 365, 0) ) |> # replace the two days in december as day 0 (first measurement)
  group_by(tank, day.of.year, size, ration) |> # group by tank, day, size, and ration
  summarise(weight = mean(weight_g), sd_w = sd(weight_g), se_w = sd_w/sqrt(n())) |> # calculate mean weight per tank for each day (each tank represents one value)
  arrange(day.of.year) |> # sort by day
  group_by(tank, size, ration) |> # regroup data
  # calculate SGR using lag()
  mutate(sgr_w = (log(weight) - log(lag(weight))) / (day.of.year - lag(day.of.year)) * 100 ) |>  # SRG = ( ln(w2)-ln(w1) ) / (t2 - t1 ) * 100
  summarise(sgr = mean(sgr_w, na.rm = TRUE) ) |> # average sgr across entire study for each tank
  ungroup() |> 
  mutate(ration = factor(ration)) # convert ration to factor (for graphing)


data3 <- LW |> 
  mutate( Date = ymd( paste(year, month, day, sep = "-")), # format date
          day.of.year = yday(Date)) |> # day of year
  mutate(day.of.year = replace(day.of.year, day.of.year >= 365, 0) ) |> # replace the two days in december as day 0 (first measurement)
  mutate(K = weight_g/(mmSL*0.1)^3*100) |>  # calculate K for each fish
  group_by(tank, day.of.year, size, ration) |> # group by tank, day, size, and ration
  summarise(fulton = mean(K), fulton.sd = sd(K), fulton.se = fulton.sd/sqrt(n()) ) |> # calculate mean K per tank for each day (each tank represents one value)
  ungroup() |> 
  mutate(ration = factor(ration)) # convert ration to factor (for graphing)
  

  
# ----- Figure 1: Temperature (data1) ------
# objectives
# geom_point()
# format points
# add a horizontal line at 0 °C
# adjust text themes

# start with reviewing the data
head(data1)

# Figure 1 
ggplot(data = data1) + # data
  geom_point(aes( x = Date,
                  y = Temp.C), # x and y axis
             size = 1) + # size of point
  geom_hline(yintercept = 0, linetype = "dashed") + # add a horizontal dashed line
  theme_bw() + # set the theme of the figure
  labs( x = "Date",
        y = "Temperature (C)",
        title = "Daily water temperature of experimental tanks") + # specify labels
  # themes determine the details of the figure (text, position, colours, etc)
  theme(panel.grid = element_blank(),  # remove grid lines
        plot.title = element_text(size = 14, hjust = 0.5, # size and position of title (center on plot)
                                  margin = margin(b = 10)), # move title up from top of plot
        axis.text = element_text(size = 11), # format axis text
        axis.title.x = element_text(size = 12, margin = margin(t = 10)), # format x axis title
        axis.title.y = element_text(size = 12, margin = margin(r = 10)), # format y axis title
        axis.text.x = element_text(angle = 90, vjust = 0.5)) + # angle axis text to 90 degrees
  scale_y_continuous(breaks = seq(from = -1, to = 3, by = 0.5)) + # set scale
  scale_x_date(date_breaks = "2 weeks", # set date breaks
               date_labels = "%d-%b %y") # set date label format
# save the figure
# you can save figures many ways, but ggsave allows more options for saving
# setting size and dpi, for example
ggsave(plot = last_plot(), filename = "Fig1.png", device = "png",
       height = 7, width = 8, units = "in", dpi = 600)

# ----- Figure 2: SGR (data2) -----
# introduce geom_boxplot()
# combine with geom_point()
# facet_wrap()
# adjusting facet themes

# check and review data2
head(data2)
summary(data2)
dim(data2)

# figure 2
ggplot(data2) +
  geom_boxplot(aes( x = ration, # creates a boxplot
                    y = sgr),
               size = 0.75, # adjust the size of the lines
               width = 0.5, # adjust width of boxplot
               colour = 'black', # colour of lines
               outlier.shape = NA) + # removes outlier point
  geom_jitter(aes( x= ration, # add jitter points on top of boxplot
                  y = sgr ),
              width = 0.25, # width of jitter points (how big of a spread)
              colour = 'grey30', # colour
              alpha = 0.7) + # transparency
  facet_wrap(~size, # facet wrap by size -- multi panel plot
             labeller = as_labeller( c("large" = "Large", # use labeller to change names of labels
                                       "small" = "Small"))) +
  theme_bw() +
  labs( x = "Ration (% body weight)",
        y = "SRG (% g/day)") +
  theme(panel.grid = element_blank(), 
        axis.text = element_text(size = 11),
        axis.title.x = element_text(size = 12, margin = margin(t = 10)),
        axis.title.y = element_text(size = 12, margin = margin(r = 10)),
        strip.text = element_text(size = 12), # change facet label text
        strip.background = element_rect(fill = "lightblue")) # change facet label background

# ------ Figure 3: condition over time (data3) ------
# combining pipes with ggplot
# geom_point vs geom_jitter
# classify with shapes
# adding regression lines
# formatting legend

head(data3)

ggplot(data3) +
  geom_smooth(aes(x = day.of.year, # geom smooth is used to model data/ add a regression lne
                  y = fulton,
                  linetype = ration,
                  fill = ration),
              method = "lm", colour = 'black') + # very important to state method (default is loess for GAM)
  geom_jitter(aes(x = day.of.year,
                  y = fulton,
                  shape = ration,
                  fill = ration)) +
  facet_wrap(~size) +
  theme_bw() +
  scale_shape_manual(values = c(25, 22:24)) +
  scale_fill_brewer(palette = "Accent") +
  labs(fill = "Ration",# use labs to specify legend title
       shape = "Ration", 
       linetype = "Ration") + # need to specify for each variable (in our case, fill, shape, and linetype)
  theme(legend.text = element_text(size = 11),
        legend.position = "bottom")


# Last thing!
# you can pipe data directly into ggplot
data3 |> 
  filter(size == "large") |> 
  ggplot() +
  geom_point(aes(x = day.of.year,
                 y = fulton))

# ggarrange from ggpubr package is a great tool to create multipanel plots for publications