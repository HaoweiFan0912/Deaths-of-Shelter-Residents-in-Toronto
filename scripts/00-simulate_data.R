#### Preamble ####
# Purpose: Simulates data
# Author: Haowei Fan
# Date: 21 September 2024
# Contact: haowei.fan@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(lubridate)

#### Simulate data ####

# Set seed for reproducibility.
set.seed(912)

# The start year is 2007, and the end year is 2024.
years <- seq(2007, 2024)

# There are 12 months in a year.
months <- seq(1, 12)

# There are four seasons in a year.
seasons <- rep(c("spring", "summer", "autumn", "winter"))

# I assume the number of decedents follows poisson distribution with mean of 8.
total_decedents <- rpois(length(years) * 12, 8)

# Begin to simulate data
simulated_data <-
  tibble(
    year = rep(years, each = 12),
    month = rep(months, times = length(years)),
    total_decedents = total_decedents
  )

# Add another column to the data called season.
# When month is "Mar", "Apr", or "May", season is Spring.
# When month is "Jun", "Jul", or "Aug", season is Summer.
# When month is "Sep", "Oct", or "Nov", season is Autumn.
# When month is "Dec", "Jan", or "Feb", season is Winter.
simulated_data <- simulated_data %>%
  mutate(season = case_when(
    month %in% c(3, 4, 5) ~ "Spring",
    month %in% c(6, 7, 8) ~ "Summer",
    month %in% c(9, 10, 11) ~ "Autumn",
    month %in% c(12, 1, 2) ~ "Winter"
  ))

# Format the year_month column.
simulated_data <- simulated_data %>%
  mutate(year_month = paste(year, month, sep = "-"))

# Delete useless columns.
simulated_data <- simulated_data %>%
  select(-year, -month)

# Convert year_month to a date using ym (lubridate package)
simulated_data <- simulated_data %>%
  mutate(year_month = ym(year_month))

# I am only interested in the period from 2007-3 to 2024-2.
simulated_data <- simulated_data %>%
  filter(year_month >= ym("2007-03") & year_month <= ym("2024-02")) %>%
  mutate(year_month = format(year_month, "%Y-%m"))

# Rearrange the columns to readable format.
simulated_data <- simulated_data %>%
  select(year_month, season, everything())

# Write csv
write_csv(simulated_data, "data/analysis_data/simulated_data.csv")
