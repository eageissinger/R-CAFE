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


# # if you haven't used these packages before, run the following line of code
# install.packages("tidyverse")
# install.packages("lubridate")

# load packages into R
library(tidyverse)
library(lubridate)

# 
# # alternative to loading all of tidyverse
# install.packages("dplyr")
# install.packages("lubridate")
# install.packages("ggplot2")
# 
# #load packages in R
# library(dplyr)
# library(lubridate)
# library(ggplot2)


# ----- Load Data ------
temperature <- read.csv("./data/CHONE121_tanktemperature.csv") # water temperature

LW <- read.csv("./data/CHONE121_codlengthweight.csv") # length and weight data


# ----- Format and summarise data -----

data1 <- temperature |> 
  mutate( Date = ymd(paste(year, month, day, sep = "-" ))) |> # format date
  group_by(Date) |> # group data by date
  summarise(Temp.C = mean(temperature), TempSD = sd(temperature)) # calculate daily temperature across all tanks


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


  
# ----- Figure 1: Temperature ------
# objectives
# geom_point()
# format points
# add a horizontal line at 0 °C
# adjust text themes

ggplot(data1) +
  geom_point(aes( x = Date,
                  y = Temp.C), size = 1) +
  geom_hline(yintercept = 0, linetype = 'dashed', size = 1 ) + 
  labs( x = "Date",
        y = "Daily temperature (°C)",
        title = "Daily water temperature of experimental tanks") +
  theme_bw(base_rect_size = 1.5) +
  theme(panel.grid = element_blank(),
        plot.title = element_text(size = 14, hjust = 0.5, margin = margin( b = 10)),
        axis.title.x = element_text( size = 12, margin = margin( t = 15) ),
        axis.title.y = element_text( size = 12, margin = margin( r = 10) ),
        axis.text = element_text(size = 11),
        axis.text.x = element_text(angle = 90, vjust = .5) ) +
  scale_x_date(date_breaks = "months",
               date_labels = "%b %Y") +
  scale_y_continuous(breaks = seq(from = -1, to = 3, by = .5 ) )


# ----- Figure 2: SGR -----
# introduce geom_boxplot()
# combine with geom_point()
# facet_wrap()
# adjusting facet themes

ggplot(data2) +
  geom_boxplot(aes( x = ration,
                  y = sgr),
               size = .75,
               width = .5,
               colour = 'black') +
  geom_jitter(aes( x = ration,
                   y = sgr),
              colour = 'grey30',
              width = .25) +
  geom_hline(yintercept = 0, linetype = 'dashed', size = 1) +
  facet_wrap(~size, 
             labeller = as_labeller(c("large" = "Large",
                                      "small" = "Small"))) +
  labs( x = "Ration (%)",
        y = "SGR (% g/day)",
        title = "Specific growth rate of large and small juvenile Atlantic cod") +
  theme_bw(base_rect_size = 1.5) +
  theme(panel.grid = element_blank(),
        plot.title = element_text(size = 14, hjust = 0.5, margin = margin( b = 10)),
        axis.title.x = element_text( size = 12, margin = margin( t = 15) ),
        axis.title.y = element_text( size = 12, margin = margin( r = 10) ),
        axis.text = element_text(size = 11),
        strip.text = element_text(size = 12),
        strip.background = element_rect(fill = 'lightblue'))
  


# ------ Figure 3: condition through time ------
# combining pipes with ggplot
# geom_point vs geom_jitter
# classify with shapes
# adding regression lines
# formatting legend

data3 |> 
  filter(size == 'small') |> 
  ggplot() +
  geom_jitter(aes(x = day.of.year,
                  y = fulton,
                  shape = ration),
              size = 2) +
  geom_smooth(aes(x = day.of.year,
                  y = fulton,
                  linetype = ration,
                  fill = ration),
              method = "lm", colour = 'black', alpha = 0.3) +
  theme_bw() 

ggplot(data3) +
  geom_jitter(aes(x = day.of.year,
                  y = fulton,
                  shape = ration,
                  fill = ration),
              size = 2) +
  geom_smooth(aes(x = day.of.year,
                  y = fulton,
                  linetype = ration,
                  fill = ration),
              method = "lm", colour = 'black', alpha = 0.3) +
  facet_wrap(~size, 
             labeller = as_labeller(c("large" = "Large",
                                      "small" = "Small"))) +
  labs( x = "Day of Experiment",
        y = "Fulton's K",
        title = "Fulton's K condition factor \n from Jan to April 2017",
        linetype = "Ration",
        fill = "Ration",
        shape = "Ration") +
  theme_bw(base_rect_size = 1.5) +
  theme(panel.grid = element_blank(),
        plot.title = element_text(size = 14, hjust = 0.5, margin = margin( b = 10), lineheight = 1.2),
        axis.title.x = element_text( size = 12, margin = margin( t = 15) ),
        axis.title.y = element_text( size = 12, margin = margin( r = 10) ),
        axis.text = element_text(size = 11),
        strip.text = element_text(size = 12),
        legend.position = "bottom",
        legend.text = element_text(size = 11),
        legend.title = element_text(size = 12)) +
  scale_shape_manual(values = c( 25, 22:24 ) ) +
  scale_fill_brewer(palette = "Accent")


# Saving figures
