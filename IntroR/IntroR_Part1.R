# R Training Introduction

# Objectives:
# describe purpose and use of each pane in RStudio and IDE
# Locate buttons and options in the RStudio IDE
# Define a variable
# Assign data to a variable
# Manage a workspace in an interactive R session
# Use mathematical and comparison operators
# Call functions
# manage packages



# When to use the console and when to use an R script

# the console is where the "action" happens. However, saving code from the console can be cumbersome (but possible by accessing your history)
# Typing directly in the console can be useful if you are doing a quick calculation or double checking variables and values
# If you want to save your work, it is best to use an R script. This allows for code to be accessed and rerun readily
# R scripts also help with reproducability and quality control, because you always have a record of what was done


#----- R as a calculator ------
1+100 # try typing directly into the console (bottom panel) as well

1 + # this is an unfinished statement
  # escape to exit (Ctrl+C if using R from command line)
  
1 + 10 # always finish your statements


# hashtag is a comment
# this line wont run  

# ---- R as a calculator -----
# respects the laws of PEMDAS
# Parentheses ()
# Exponents ^
# Multiplication *
# Division /
# Addition +
# Subtraction -

(3 +5 ) * 2
3 + 5 * 2

# really large number - scientific notation
2/10000

# can write in scientific notation as well
5e3

# ----- Functions in R ------

getwd() # no argument necessasry
# some functions require an argument


# Mathematical functions
sin() # error because there was no argument as input
sin(1)
ln(0) # not the right function! 
log(0) # this is natural log
log(1)


# how to get information on functions
?sin() # use a "?" before a function to pull up the help menu (bottom right panel of RStudio) 

# ----- Comparing things -----
1 == 1 # is true
1 != 1 # 1 does not eaqual 1 is false

1 < 2 # we will use conditional statements often when filtering data (come to future sessions)


# ---- Variables and assignments ------
# store a variable
x <- 1/40 # assignment character is used to store variables <-
x
y <- 100
y

# perform functions on your store values
log(x)

# in addition to functions, we can add variable together
x + y

x * y

z <- x + y
z

# R is sequential
# I'm going to change x
x <- 40

z <- x + y 
# rerun calculation with new x
z # z is now different

# best technique to avoid getting mixed up is distinct variable names




# ----- Vectorization ------
# What is a vector?
1:5 # colon tells to you run integers from start to end
1:10

# can execute calculation across entire vector
2^(1:5)

# we can store our vectors
v <- 1:5


v

# R is case sensitive
V # upper case

# you don't need spaces (but helps people read scripts if you are sharing/collaborating)
v<-1:5

# assignment variables
# best practice is to use <-
# you can use = (and will see it in older scripts), but = is often within in functions, be consistent!

2^x
2^v

# ----  managing your environment ----
# CTRL +L clears console


# examples of a few useful functions

# what is in the env
ls()
ls # without the brackets will call the code for the specific function (a look under the hood)

# remove varialbes in your environment
rm(v)
v
# to remove everything at once
rm( list = ls() ) # use this with caution. My recommendation is to clean envirnment with intent - know what you are removing rather than remove all


# ----- Challenge exercise -----

# What will be the value of each variable after running each line?
# hint: work through line by line
mass <- 47.5
age <- 122
mass <- mass * 2.3 # what happens if it runs again
age <- age - 20

# how would you keep mass the same but re-run the equation?
mass * 2.3
# new variable name!
mass2 <- mass * 2.3




# how do check if mass is greater than age?
# there are multiple answers
mass > age
mass
age

# last challenge
# clean environment by only removing age and mass
rm(age,mass)



# ---- R packages -----

# last function we will use today.
# install.packages()

# R coding language comes with base functions
# ls()
# rm
# log
# getwd()

# but if it had every funtion we ever use constantly loaded

# ggplot2
# plyr
# gapminder

install.packages(ggplot2)
# when you install packages. you need "" around package name
install.packages("ggplot2")

ggplot() # i have installed in R, but havent called in the package
library(ggplot2) # no quotation marks necessary
# how to get rid of a loaded packge

# Seeking help
# ?()
?rm()
