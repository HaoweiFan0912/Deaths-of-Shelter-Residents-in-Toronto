#### Preamble ####
# Purpose: Tests codes.
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
simulated_data <- read_csv("data/analysis_data/simulated_data.csv")

# Test 1: Ensure year_month format is correct (YYYY-MM)
all(grepl("^\\d{4}-\\d{2}$", simulated_data$year_month))


# Test 2: Ensure year_month is in the right period.
all(ym(simulated_data$year_month) >= ym("2007-03") &
  ym(simulated_data$year_month) <= ym("2024-02"))


# Test 3: Ensure all seasons are assigned correctly
valid_seasons <- c("Spring", "Summer", "Autumn", "Winter")
all(simulated_data$season %in% valid_seasons)


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
month_from_data <- as.numeric(substr(simulated_data$year_month, 6, 7))
correct_season <- tibble(correct_season = sapply(month_from_data, get_season))
all(correct_season$correct_season == simulated_data$season)


# Test 5: Check for valid total decedents
all(simulated_data$total_decedents >= 0 & # is non-negative?
  simulated_data$total_decedents == as.integer(simulated_data$total_decedents)) # is integer?

# now I will test the actual data.
analysis_data <- read_csv("data/analysis_data/analysis_data.csv")

# Test 6: Ensure year_month format is correct (YYYY-MM)
all(grepl("^\\d{4}-\\d{2}$", analysis_data$year_month))


# Test 7: Ensure year_month is in the right period.
all(ym(analysis_data$year_month) >= ym("2007-03") &
  ym(analysis_data$year_month) <= ym("2024-02"))


# Test 8: Ensure all seasons are assigned correctly
valid_seasons <- c("Spring", "Summer", "Autumn", "Winter")
all(analysis_data$season %in% valid_seasons)


# Test 9: the actual season matches the expected season
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
month_from_data <- as.numeric(substr(analysis_data$year_month, 6, 7))
correct_season <- tibble(correct_season = sapply(month_from_data, get_season))
all(correct_season$correct_season == analysis_data$season)


# Test 10: Check for valid total decedents
all(analysis_data$total_decedents >= 0 & # is non-negative?
  analysis_data$total_decedents == as.integer(analysis_data$total_decedents)) # is integer?
