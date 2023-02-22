# Data Visualization
# Feb 22 2023

# Objectives:
# learn basic strcure of ggplot
# introduce available figure formats
# manipulate aeshtetics of plots

# before we begin:
# two new packages today
# install of the new packages
install.packages("ggplot2") # plotting
install.packages("lubridate") # working with dates

# ---- packages ----
library(dplyr)
library(ggplot2)
library(lubridate)

# check where you are

# review from last week! (Yay Reviews!)
# find out where your current R directory is
# if needed, set your working directory 

# where are we?
getwd()
setwd("C:/Users/Geissingere/Documents/Rtraining/")
getwd()

# ---- Data ----
# read in data
# another review from last week!
# we are working with csv files, so you can use the read.csv() function

temperature <- read.csv("./data/CHONE121_tanktemperature.csv")

# more review!
# Data checks
head(temperature)
glimpse(temperature) # same as str()
summary(temperature)
# everything is looking good
# except for our date column

# ---- Dates with lubridate ----

# before plotting time, we need a date column in dttme format
# use our lubridate package
# ymd() needs a columns that has the full date
## NOTE: if you haven't updated R, use %>% for your pipe

t <- temperature |> 
  mutate(Date = paste(year, month, day, sep = "-"),
         Date = ymd(Date))

# a few different ways to write this
# one option
t <- temperature |> 
  mutate(Date = ymd( paste( year, month, day, sep = "-")))

# another option
t <- temperature |> 
  mutate(Date = paste(year, month, day, sep = "-")) |> 
  mutate(Date = ymd(Date))

# all three produce the same thing
glimpse(t)


# ---- Plotting data in R -----
# The good stuff
# Plotting!!!!!
# base plot
plot(x = t$Date, y = t$temperature)


# ggplot has a lot of options for high quality figures
# ggplot is built through layers (geoms)
ggplot(data = t)
# when you just call ggplot without a geom, you are letting R know you want to plot a figure,
# but you haven't specified what you are using (which values for x and y, what type of plot, etc)

# add a geom
# we will start with geom_point() --- a scatter plot
ggplot(data = t) +
  geom_point(aes(x = Date, y = temperature))
# aes() calls the data (specified in ggplot()) and states which x and y values you are plotting

# you can change the base format using themes
ggplot(data = t) +
  geom_point(aes(x = Date, y = temperature)) +
  theme_bw()

# you can change from a scatter plot to a line plot by changing the geom
ggplot(data = t) +
  geom_line(aes(x = Date, y = temperature)) + # line plot 
  theme_bw()

# ---- Combining dplyr and ggplot -----

# want to have daily average temperature
# more review from last week!
t |> 
  group_by(Date, tank) |> # group by tank and by date
  summarise(Temp.C = mean(temperature)) |> 
  ggplot() +
  geom_line(aes(x = Date, # date on x axis
                y = Temp.C,  # temperature on y axis
                colour = as.character(tank))) + # different colour for each tank
  theme_bw()

# we don't care about individual tanks
# create a summary across entire experiment with sd calculated
t |> 
  group_by(Date) |> #group by Date only
  summarise(Temp.C = mean(temperature),
            SD.Temp = sd(temperature)) |> # summary output for the figure
  ggplot() +
  geom_line(aes(x = Date, y = Temp.C)) + # line with x and y 
  # add shading based on standard deviation
  geom_ribbon(aes(x = Date, 
                  ymin = Temp.C - SD.Temp,
                  ymax = Temp.C + SD.Temp), # ribbon with min and max
              alpha = 0.3) + # reduce the opacity
  # add custom labels
  labs( x = "Date",
        y = "Temperature (C)",
        title = "Tank Temperature 2017") +
  theme_bw() +
  # additional changes using theme()
  theme(plot.title = element_text(size = 16, hjust = 0.5), # chnage title text size and position
        axis.title = element_text(size = 12), # change axis title (x and y) size
        axis.text = element_text(size = 11)) # change axis test (x and y)


# ----- Hour 2: Explore ggplot -----

# Try and change the color of the line
# try out different themes - pure exploration
# see if you can create a bar plot (use the help feature for this) geom_

# changing colour of the line
# colors are specified on the layer associated with geom_line()
t |> 
  group_by(Date) |> #group by Date only
  summarise(Temp.C = mean(temperature),
            SD.Temp = sd(temperature)) |> # summary output for the figure
  ggplot() +
  geom_line(aes(x = Date, y = Temp.C),
            colour = 'purple') + # important to change line colour OUTSIDE of the aes() function, but within geom_line()
  geom_ribbon(aes(x = Date,
                  ymin = Temp.C - SD.Temp,
                  ymax = Temp.C + SD.Temp), # ribbon with min and max
              alpha = 0.3) + # reduce the opacity
  labs( x = "Date",
        y = "Temperature (C)",
        title = "Tank Temperature 2017") +
  theme_bw() +
  theme(plot.title = element_text(size = 16, hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 11),
        panel.grid = element_blank())

# different themes
t |> 
  group_by(Date) |> #group by Date only
  summarise(Temp.C = mean(temperature),
            SD.Temp = sd(temperature)) |> # summary output for the figure
  ggplot() +
  geom_line(aes(x = Date, y = Temp.C),
            colour = 'purple') + # important to change line colour OUTSIDE of the aes() function, but within geom_line()
  geom_ribbon(aes(x = Date,
                  ymin = Temp.C - SD.Temp,
                  ymax = Temp.C + SD.Temp), # ribbon with min and max
              alpha = 0.4) + # reduce the opacity
  labs( x = "Date",
        y = "Temperature (C)",
        title = "Tank Temperature 2017") +
  theme_dark() + # ggplot comes up preset themes (but you can also create your own)
  theme(plot.title = element_text(size = 16, hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 11))

# convert to a bar plot
t |> 
  group_by(Date) |> #group by Date only
  summarise(Temp.C = mean(temperature),
            SD.Temp = sd(temperature)) |> # summary output for the figure
  ggplot() +
  # bar plot!
  geom_bar(aes(x = Date, y = Temp.C),
           stat = "identity",
           fill = 'darkblue',
           colour = 'pink') +
  labs( x = "Date",
        y = "Temperature (C)",
        title = "Tank Temperature 2017") +
  theme_bw() +
  theme(plot.title = element_text(size = 16, hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 11),
        panel.grid = element_blank()) # panel.grid controls the grid lines of your plot, use element_blank() to remove them
