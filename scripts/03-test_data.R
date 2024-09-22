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
library(testthat)

#### Test data ####

# select target data
data <- simulated_data

# Test 1: Ensure year_month format is correct (YYYY-MM)
test_that("year_month format is YYYY-MM", {
  expect_true(all(grepl("^\\d{4}-\\d{2}$", data$year_month)))
})

# Test 2: Ensure year_month is in the right period.
test_that("year_month format between 2007-3 and 2024-2", {
  expect_true(all(ym(data$year_month) >= ym("2007-03") 
                  & ym(data$year_month) <= ym("2024-02")))
})

# Test 3: Ensure all seasons are assigned correctly
test_that("Seasons are correctly assigned", {
  valid_seasons <- c("Spring", "Summer", "Autumn", "Winter")
  expect_true(all(data$season %in% valid_seasons))  
})

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
test_that("Seasons are correctly assigned based on months", {
  # Extract the month from the 'year_month' column
  data <- data %>%
    mutate(month = as.numeric(format(as.Date(paste0(year_month, "-01")), "%m")),
           correct_season = sapply(month, get_season))
  
  # Check if the season is correctly assigned
  expect_true(all(data$season == data$correct_season))
})

# Test 5: Check for valid total decedents
test_that("Total decedents column contains valid values", {
  expect_true(all(data$total_decedents >= 0) & # is non-negative?
                all(data$total_decedents == as.integer(data$total_decedents))) 
  # is integer?
})

# Test 6: Check for valid 'male'
test_that("male column contains valid values", {
  expect_true(all(data$male >= 0) & # is non-negative?
                all(data$male == as.integer(data$male))) # is integer?
})

# Test 7: Check that the total_decedents column matches male + female
test_that("total_decedents equals male + female", {
  expect_true(all(data$total_decedents == data$male + data$female))  
})

