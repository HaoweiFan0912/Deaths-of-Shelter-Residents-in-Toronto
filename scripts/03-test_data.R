#### Preamble ####
# Purpose: Tests codes
# Author: Haowei Fan
# Date: 22 September 2024
# Contact: haowei.fan@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

#### Test data ####

# select target data
data <- read_csv("data/analysis_data/simulated_data.csv")

# Test 1: Ensure year_month format is correct (YYYY-MM)
all(grepl("^\\d{4}-\\d{2}$", data$year_month))


# Test 2: Ensure year_month is in the right period.
all(ym(data$year_month) >= ym("2007-03") 
    & ym(data$year_month) <= ym("2024-02"))


# Test 3: Ensure all seasons are assigned correctly
valid_seasons <- c("Spring", "Summer", "Autumn", "Winter")
all(data$season %in% valid_seasons)


# Test 4: the actual season matches the expected season
# Function to determine the correct season based on the month
get_season <- function(month) {
  if (month %in% 3:5) {
    return("Spring")
  } else if (month %in% 6:8) {
    return("Summer")
  } else if (month %in% 9:11) {
    return("Autumn")
  } else {
    return("Winter")
  }
}
# Test to check if the 'season' column matches the correct season
correct_season <- tibble(correct_season = sapply(data$month, get_season))
all(correct_season$correct_season == data$season)


# Test 5: Check for valid total decedents
all(data$total_decedents >= 0 & # is non-negative?
      data$total_decedents == as.integer(data$total_decedents)) # is integer?

# Test 6: Check for valid 'male'.
all(data$male >= 0 & # is non-negative?
      data$male == as.integer(data$male)) # is integer?

# Test 7: Check that the total_decedents column matches male + female.
all(data$total_decedents == data$male + data$female)

# now I will test the actual data.
data <- read_csv("data/analysis_data/analysis_data.csv")

# Test 8: Ensure year_month format is correct (YYYY-MM)
all(grepl("^\\d{4}-\\d{2}$", data$year_month))


# Test 9: Ensure year_month is in the right period.
all(ym(data$year_month) >= ym("2007-03") 
    & ym(data$year_month) <= ym("2024-02"))


# Test 10: Ensure all seasons are assigned correctly
valid_seasons <- c("Spring", "Summer", "Autumn", "Winter")
all(data$season %in% valid_seasons)


# Test 11: the actual season matches the expected season
# Function to determine the correct season based on the month
get_season <- function(month) {
  if (month %in% 3:5) {
    return("Spring")
  } else if (month %in% 6:8) {
    return("Summer")
  } else if (month %in% 9:11) {
    return("Autumn")
  } else {
    return("Winter")
  }
}
# Test to check if the 'season' column matches the correct season
correct_season <- tibble(correct_season = sapply(data$month, get_season))
all(correct_season$correct_season == data$season)


# Test 12: Check for valid total decedents
all(data$total_decedents >= 0 & # is non-negative?
      data$total_decedents == as.integer(data$total_decedents)) # is integer?

# Test 13: Check for valid 'male'.
all(data$male >= 0 & # is non-negative?
      data$male == as.integer(data$male)) # is integer?

# Test 14: Check that the total_decedents column matches male + female.
all(data$total_decedents == data$male + data$female)





