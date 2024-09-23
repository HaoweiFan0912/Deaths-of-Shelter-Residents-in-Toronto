#### Preamble ####
# Purpose: Cleans the raw data.
# Author: Haowei Fan
# Date: 22 September 2024
# Contact: haowei.fan@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

cleaned_data <-
  raw_data |>
  janitor::clean_names() |> # format column names
  select(-x_id, -transgender_non_binary_two_spirit, -male, -female) |> # delete unless columns
  mutate(month_numeric = sprintf("%02d", match(month, month.abb)),  # Convert month abbreviation to numeric
         year_month = paste(year, month_numeric, sep = "-")) %>% # New column contains year and month in the format XXXX_XX
  select(-year, -month) |>   # Keep only the new 'year_month' column
  mutate(season = case_when(
    month_numeric %in% c("03", "04", "05") ~ "Spring", # match months to actual season
    month_numeric %in% c("06", "07", "08") ~ "Summer",
    month_numeric %in% c("09", "10", "11") ~ "Autumn",
    month_numeric %in% c("12", "01", "02") ~ "Winter"
  )) |>
  select(-month_numeric) |> # delete unless columns
  select(year_month, season, everything()) |> # rearranging columns into a readable format.
  filter(ym(year_month) >= ym("2007-03") & ym(year_month) <= ym("2024-02")) |> # delete unwanted rows.
  tidyr::drop_na() # drop rows contains empty unit.

  
cleaned_data
#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
