# ---- Introduction to R part 2 -----
# Data structures
# Exploring dataframes


# ---- Data structures----

# create a dataframe called cats

cats <- data.frame(coat = c("calico", "black", "tabby"), 
                   weight = c(2.1, 5.0, 3.2),
                   likes_string = c(1, 0, 1) )

# save your cats file as a csv
write.csv(x = cats, file = "feline-data.csv", row.names = TRUE)

# if you ever have trouble and don't know what input is needed
# check the help function
?write.csv()

# read.csv for csv # read.delim for .txt (will talk about this more in the next session!)


# ---- Exploring data -----
# what does our data look like
cats

# next we will call up individual columns (useful for large datasets)
# use the $ sign between a dataframe and a column to indicate which one you want
cats$weight
cats$coat

# columns are vectors so we can do operations on them
# scale the weight and add 2 kg
cats$weight + 2

# use the paste function
paste("My cat is", cats$coat)
paste(cats$coat, cats$weight) # goes in order throughout dataframe
cats # makes a statement
# how paste works:
# takes two arguemtns and puts them togehter
# argument 1: "My cat is", 
# argument 2: cat coat color (there are three)
# spits out three outputs with arg 1 ("My cat is") and arg 2 (coat)
# this example shows how functions work across dataframes
# paste goes through each row (each value in the vector) to perform the function

# working with two different types of columns
cats$weight + cats$coat
# what is the problem? Two different data types

# ---- Data types ----

# what type of data is weight?
typeof(cats$weight) # double (or numeric)
# 5 main types of data
# double
# integer
# complex
# logical
# character
typeof(3.14) # numeric
typeof(1L) # L suffix foreces number to an interger
typeof(1) # one is read as a double (numeric) in R if not specified as integer
typeof(cats$coat) # "character"
typeof(1+1i) #complex
typeof(TRUE) # logical

cats
# check the datatypes of your entire dataset using str()
str(cats) # one of my top used functions before I start working with data in R

# --- Vectors ----
# vector in R is an ordered list of things, with the important condition:
# Everytrhing in thevector must be the same basic data type
my_vector <- vector(length = 3) # default datatype is logical
my_vector # need to choose your datatype

# new vector
another_vector <- vector(mode = "character", length = 3)
another_vector
str(another_vector)

# these examples are all empty vectors, but they all need to have a specific datatype associated with them

# cats$weight is a vector
str(cats$weight)

# vectors with content
combine_vector <- c(2, 6, 3 )
combine_vector
str(combine_vector) # we do not need to state the datatype for this vector because we have specified our numbers
# R will automatically assign the data type (double)

# let's see what happens when our vector does not have the same datatype
quiz_vector <- c(2, 6, "3")
quiz_vector # all of our numbers now have quotation marks
str(quiz_vector) # because there is one character present, all values have been converted to character

# more applicable example
# the following example is what would happen if you read in data where one number was entered with a comma instead of a decimal
example1 <- c(1.0, 2.8, "3,8")
str(example1)

example2<- c(1.0, 2.8, 3,8) # this example shows how R uses commas as separators. Always be mindful to use decimal instead of comma for digits
example2

# when numbers are characters.....
example1 + 1 # can't perform mathematical functions on characters
example1

# ---- Coercing vectors -----
# can convert vectors
character_vector_example <- c('0','2', '4')
character_vector_example

character_to_numeric <- as.numeric(character_vector_example) # converts character to a number
character_to_numeric

# be mindful that coercion does not always produce expected results depending on what is "under the hood"
# See Challenge problem 2 (line XXX)

# ---- Dataframes ----

# column in data.frames are vectors
str(cats$weight)
cats
str(cats)

# you can change the name of a column
names(cats)
names(cats)[2] <- "weights_kg" # square bracket says item two in the names vector
names(cats)

# adding data to our dataframe
age <- c(2, 3, 5)
cats
# combine age with your dataframe
# use cbind() function
cbind(cats, age)
cats # no age!

# need to store the change in an object (we will overwrite cats here)
cats <- cbind(cats, age)
cats

# example of another column
# this is a column of where the cats were found
another_column <- c("porch", "tree")
cbind(cats, another_column)

# what is you only have 2 out of three observations?
# third entry is NA
column <- c("porch", "tree", NA)
cbind(cats, column)

# remove columns using subsetting
# we want to remove the third row of data
cats[-3, ] # - says to remove, 3 is the third row, when you have , 
# folllowed by empty space, it means all compoentns

# a little more on subsetting
cats[3,1] # 3rd row first column
cats
cats[3, ] # 3rd row all columns
cats[ , 2 ] # all rows, second column

# --- exploring larger datasets ----

# install the following package
# gapminder

install.packages("gapminder")
# load package
library(gapminder)

# load data from thepackage
data("gapminder")

# first things I like to do with data
head(gapminder) # looks at first few rows of data
str(gapminder) # the structure of data, including data types
nrow(gapminder) # number of rows/observations
length(gapminder) # number of columns
dim(gapminder) # overall dimensions
tail(gapminder) # last few rows of data
summary(gapminder) # basic summary of each column
View(gapminder) # opens up new window with data


# ---- Exercises ----

# Challenge 1:
# I have shown to read the first 6 rows, and last 6 rows
# how would you look at the middle of your data
# take two minutes
# we know how to look at the head() and tail()
dim(gapminder)
tail(gapminder, n = 800) # works best when data is a tibble

# convert tibble to dataframe
df <- as.data.frame(gapminder)

tail(df, n = 800) # differences between tibble and dataframe

# other solutions
gapminder[800, ] # concatinate (sp????), square brackets subset
gapminder[800:810, ] # first entry is row, second is column


# Challenge 2:
# back to cats....
# Imagine that 1 cat year is equivalent to 7 humans years
# 1. create a vector called human_age by multiplying cat$age by 7
# 2.convert human_age to a factor
# 3. convert human_age back to a numeric vector using the as.numeric() function
# now divide it by 7 to get the orginal ages back
# Explain what has happend

human_age <- cats$age * 7
human_age
typeof(human_age)

human_age<- as.factor(human_age)
human_age
typeof(human_age)
levels(human_age)
human_age <- as.numeric(human_age)
human_age

# Factors look like character data, but are used to represent categorical information
# the categories will have names, but R will list the category as 1, 2, 3,..... n
# this is important to remember when trying to coerce vectors. Be mindful of how they are
# read in R

