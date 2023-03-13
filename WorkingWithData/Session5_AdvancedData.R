# Session 5: Advanced data wrangling
# this session provides a deeper dive into tidyverse functions to increase efficiency when working with data
# Cover functions from the following packages
# lubridate
# dplyr (tidyverse)
# tidyr (tidyverse)
# stringr (tidyverse)
# forcats (tidyverse)

# ----- pacakges -----
# to install:
# install.packages("tidyverse")
# install.packages("lubridate")

## tidyverse can take a while to load, 
## if you prefer to work with individual packages, you can install the following:
# install.packages(c("dplyr", "tidyr", "stringr", "forcats")) # individual tidyverse packages used below

# load into R
library(tidyverse) # dplyr, tidyr, stringr, ggplot2
library(lubridate) # dates

# if usinig individual packages, run the below section
# # load into R
# library(dplyr)
# library(tidyr)
# library(stringr)
# library(forcats)



# ----- Data -----

# before loading data
# make sure you have the correct path
getwd()
setwd("C:/Users/Username/Documents/Rtraining/")


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
# glimpse does same thing as str, but part of the dplyr package
# advantages - easier to read format/layout in the console
glimpse(LW)
glimpse(tanks)
glimpse(temperature)

# when a function has the same name across multiple packages
# specify which function you are using by package::function()
dplyr::glimpse(LW)
# if you are not sure how many package crossovers exist for a function, check the help page
?glimpse() # learn more about glimpse and which packages it is part of in the help page
# part of three packages, so always know what packages you are working with

# ---- Lubridate -----

# prepare data (using lubridate)
# format date
# create day of year column
K <- LW |> 
  mutate(Date = ymd(paste(year, month, day, sep = "-")),
         day_of_year = yday(Date)) # create a column with day of year (useful for analyses0) 
head(K)


# ---- dplyr ------

# Temperature data as monthly average for each tank
tank_temp <- temperature |> # %>% for old versions of RStudio (I recommend always using the most up-to-date R and RStudio)
  group_by(month, year, tank) |> # group by these three variables
  summarise( Temp.C = mean(temperature), # summary stats based on your grouped variables
             Temp.SD = sd(temperature)) |> 
  mutate(Temp.C = round(Temp.C, 1), # let's round() the temperature data to 0.1 because of our measurement accuracy
         Temp.SD = round(Temp.SD, 1)) |> # round(Variable, decimal)
  ungroup() # ungroup the data

# check our summary data
head(tank_temp)
glimpse(tank_temp)

# create columns (K) by mutate
# K = weight_g/(mmSL*0.1)^3*100
#  using the LW data make a our condition data
K <- K |> 
  mutate(K = weight_g/(mmSL*0.1)^3*100) # create a column with Fulton's K calculations
# you can add new columns to the working data set

# alternatively, pipes allow all of your data adjustments to happen in one line of code
K <- LW |> 
  mutate(Date = ymd(paste(year, month, day, sep = "-")),
         day_of_year = yday(Date)) |>  # create a column with day of year (useful for analyses0) 
  mutate(K = weight_g/(mmSL*0.1)^3*100) # create a column with Fulton's K calculations


# check the result of your new columns
head(K)
# there are more columns than needed,
# so we will add the select() function at the end to work with columns of interest

K <- LW |> 
  mutate(Date = ymd(paste(year, month, day, sep = "-")),
         day_of_year = yday(Date)) |>  # create a column with day of year (useful for analyses0) 
  mutate(K = weight_g/(mmSL*0.1)^3*100) |>  # create a column with Fulton's K calculations
  # going to select columns of interest only
  select(Date, tank, size, ration, mmSL, weight_g, K)

head(K)

# You can also state which columsn you *Don't* want to use with a '-' sign
# to decrease amount of typing
K <- LW |> 
  mutate(K = weight_g/(mmSL*0.1)^3*100) |> 
  mutate(Date = ymd(paste(year, month, day, sep = "-"))) |> 
  select(-year, -month, -day, -fish_num)
# importnat note
# the select function is common in many packages so you may need to specify dplyr::select()
head(K)

# finally, select works with column numbers as well, so you can select the first 4 columns
# with the following
K |> 
  select(1:4) # columns 1 through 4


# Combining dataframes together

# add temperatures to dataframe 
# explore the join functions

K_temp <- left_join(K, temperature)

dim(K_temp)
dim(K)
dim(temperature)
View(K_temp)

# too many repeats, only joining by tank, not by date
head(K)
head(temperature)

# add date to create an additional common variable
temp2 <- temperature |> 
  mutate(Date = ymd(paste(year, month, day, sep = "-")))

# we make the date column because we need the common columns to join by

K_temp <- left_join(K, temp2, by = c("tank", "Date"))
dim(K_temp)
dim(K)
dim(temp2)
# data doubles because there are two temperature values each day, but only one fish measurement


# create daily temperature to join
temp2 <- temperature |> 
  mutate(Date = ymd(paste(year, month, day, sep = "-"))) |> 
  group_by(Date,tank) |> 
  summarise(Temp.C = mean(temperature))

K_temp <- left_join(K, temp2)

# right join? 
K_temp <- right_join(K,temp2) # joins based on temperature, not based on K
# left_join will be based off of whichever datframe you list first

# stick with left_join
K_temp <- left_join(K, temp2)


# -----tidyr------

# combine size and ration to single column 
# base R with paste
K |> 
  mutate( treatment = paste(size, ration)) |> 
  head()

# tidyr with unite
K2 <- K |> 
  unite("treatment", c(size, ration), sep = "-", remove = TRUE) |> 
  mutate(treatment = paste(treatment, "%"))
head(K2)

# another useful dplyr function
# what are my treatments?
K2 |> distinct(treatment)

# we want to separate the treatment column
K2 <- K2 |> 
  separate(treatment, c("size", "ration"), sep="-")
head(K2)

# ------ stringr -----
# working with strings 

# remove % from ration
K2 |> 
  mutate(ration = str_remove(string = ration, pattern = " %") |> 
           as.numeric()) |> # stringr functions will always be characters
  glimpse()



# ----- forcats -----
# set factors and factor orders (and this will be used for next week)

glimpse(K)

# assign variables as factors
K_factor <- K |> 
  mutate(ration = factor(ration),
         size = factor(size)) # base R functions
# check the levels
levels(K_factor$ration)
levels(K_factor$size)

# reorder factors
K_factor <- K_factor |> 
  mutate(size = fct_rev(size))
levels(K_factor$size)

# dropping factors
Kdrop <- K_factor |> 
  filter(ration != "10") # we need to drop the factor level
levels(Kdrop$ration)

Kdrop <- K_factor |> 
  filter(ration != "10") |> 
  mutate(ration = fct_drop(ration))
levels(Kdrop$ration)

# Final 20 -30 minutes of today.
# option 1 is to work on your own data and apply what we've learned
# option 2 is do an excerise (below) of the current data
# option 3 is download data from github extra_data and work with new data

# cover functions from dplyr, lubridate

# background: K (which we already created) data was sampled on a monthly interval
# you want to join the average montlhy temperarre to the condition values
# hint: sort by month (take a look at lubrdiate to recreate a month var)
# skills:
# summariseing data
# creating variables
# joining data

#Major Hint 1: average montlhy temperature was created earlier in lesson
#Major Hint 2: remember what you want to join by (month) and make sure it is present
# in both dataframes
head(tank_temp)
head(K)

# example of a solution (remember, there are always multiple ways to do something)
solution <- K |> 
  mutate(Month = month(Date)) |> 
  left_join(tank_temp, by = c("tank", "Month" = "month"))
head(solution)
dim(solution)
dim(K)
