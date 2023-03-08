# Session 5: Advanced data wrangling
# this session provides a deeper dive into tidyverse functions to increase efficiency when working with data
# Cover functions from the following packages
# lubrdiate
# dplyr (tidyverse)
# tidyr (tidyverse)
# stringr (tidyverse)
# forcats (tidyverse)

# ----- pacakges -----
# to install:
install.packages("tidyverse")
install.packages("lubridate")

# load into R
library(tidyverse) # dplyr, tidyr, stringr, ggplot2
library(lubridate) # dates


# ----- Data -----
LW <- read.csv("./data/CHONE121_codlengthweight.csv")

tanks <- read.csv("./data/CHONE121_tankassignments.csv")

temperature <- read.csv("./data/CHONE121_tanktemperature.csv") 

# check data

# first few rows
head(LW)
head(tanks)
head(temperature)

# summary of data
summary(LW)
summary(tanks)
summary(temperature)

# structure of data
glimpse(LW)
glimpse(tanks)
glimpse(temperature)


# -----Initial data format ------

# Temperature data as monthly average for each tank





# create columns (K) by mutate
# K = weight_g/(mmSL*0.1)^3*100





# ---- Lubridate -----

# prepare data (using lubridate)
# format date
# create day of year column




# ---- dplyr ------
# add temperatures to dataframe 









# Next step
# outcome: want to join temperature to K dataframe for only days measured







# -----tidyr------

# combine size and ration to single column 







# ------ stringr -----
# working with strings 





# ----- forcats -----
# set factors and factor orders (and this will be used for next week)




