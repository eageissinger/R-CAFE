# ---- Working with data in R ----
# Objectives today:
# practice reading in data
# combining dataframes together
# creating new variables
# summary statistics
# exporting data

# ----- Packages -----
# dplyr (part of tidyverse)
install.packages("dplyr") # I won't be running this
library(dplyr) # dplyr is a package for working with and maniputing dataframes

# ---- Working path -----

# If you are working in a R Project, your working directory is automatically
# set to where your project is!

# if you are unsure you can alsways
# check where you are
getwd()

# if in the wrong spot,
# use setwd()
# to change your working direcotry
setwd("filepathhere")
# example
setwd("C:/Users/Geissingere/Documents/RTraining") 


# ---- Data ----

# read.csv() function
condition <- read.csv("./data/CHONE121_codcondition.csv") # set the path of where your data is
tanks <- read.csv("./data/CHONE121_tankassignments.csv")


# ---- Check our data ----
# start with condition
head(condition) # first few rows
dim(condition) # rows and columns
summary(condition) # basic summary output
str(condition) # structure and details of datatypes

# a new function to check structure of data
glimpse(condition) # does the same thing as str()

# view data in new window
View(condition) # this function is with a capital 'V'

# run the same thing with tanks
head(tanks)
dim(tanks)
summary(tanks)
glimpse(tanks)
View(tanks)

# ---- Combining two datasets -----
# combine rows when they have the same columns
# combine columns when you are joining two together
# in this case
# we have a common variable
# how to check
names(condition)
names(tanks)

# merge using common variable
# use a join function

fulldata <- left_join(condition, tanks, by = "tank") # there are different join functions, we will focus on left today
fulldata <- left_join(condition, tanks) # when you don't specify the "by" the function automatically joins based on mutual columns

# check full data
head(fulldata)
tail(fulldata)

# ----Subset data -----
day0 <- filter(fulldata, notes == "day 0")
head(day0)
tail(day0)

cond_exp <- filter(fulldata, notes != "day 0")
head(cond_exp)

# ---- Create a new variable ----
# calculate out Kwet (Fulton's Condition factor K) with wet weight

# equation: Kwet = 100 * wet_weight/(mmSL*0.1)^3

# to create a new column

# need to store the variable
newdata <- cond_exp %>% 
  mutate( Kwet = 100 * wet_weight_g / (mmSL*0.1)^3) # makes a new column
head(newdata)

# the pipe
# %>% # the tidyverse pipe (originally the dplkyr pipe)
# |> # new pipe compatible with all the above functions - no dependencies 

# short cut 
# CTRL + SHIFT + M
# |> 
  
  # ---- Summary statistics -----
# just do a summary

# use %>% or |> whichever is easier

newdata |> summarise( meanK = mean(Kwet), sdK = sd(Kwet) )

# we want to have summary statistics by treatment groups
# treatment gruops are: size, ration

# to do this, we need to group our data

my_summary <- newdata |> 
  group_by(size, ration ) |> 
  summarise( meanK = mean(Kwet),
             sdK = sd(Kwet),
             minSL = min(mmSL),
             maxSL = max(mmSL),
             N = n() )

# export our summary file
# write.csv

write.csv(my_summary, "./output/Ksummary.csv", row.names = FALSE)



# when I forget what my data looks like
names(newdata)


# ----- Challenge of the day -----

# Using the day0 data frame, add size classes (large and small)
# mmSL <= 84 are "small"
# mmSL >= 89 are "large"

# functions you will need
# mutate()
# replace() ## this one is new, use "help" resources to learn how it works

# Then:
# Create a summary table grouped by size 


# Solution
# replace values


day0 |> 
  mutate( Kwet = 100 * wet_weight_g / (mmSL*0.1)^3) |>  # makes a new column
  mutate( size = replace(size, mmSL <= 84, "small" ), 
          size = replace(size, mmSL >= 89, "large" ) ) |> 
  group_by(size) |> 
  summarise( mean(Kwet), min(mmSL), max(mmSL) )

