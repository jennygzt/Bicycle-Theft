#### Preamble ####
# Purpose: Tests the structure and content of the simulated and cleaned Toronto
# bicycle theft datasets.
# Author: Zitong Guo
# Date: September 25, 2024
# Contact: jennygztong@gmail.com
# License: MIT
# Pre-requisites: Run the files "00-simulate_data.R"," 01-download_data.R", and
# "02-data_cleaning.R" as well as installing testthat
# Any other information needed? NONE

#### Loading Packages ####

library(tidyverse)
library(testthat)

#### Test simulated cases ####

# Test 1: Check if the dataset has 1000 rows
test_that("Dataset has 1000 rows", {
  expect_equal(nrow(simulated_data), 1000)
})

# Test 2: Check if location_type contains only the expected categories
test_that("location_type contains valid categories", {
  valid_locations <- c(
    "Apartment", "House", "Commercial", "Street/Road",
    "Park", "Other"
  )
  expect_true(all(simulated_data$location_type %in% valid_locations))
})


#### Testing the Cleaned Dataset ###

# Test 3: Check if occ_month contains only valid month names
test_that("occ_month contains valid month names", {
  expect_true(all(cleaned_data$occ_month %in% month.name))
})

# Test 4: Check if occ_date is a valid Date object
test_that("occ_date is a valid date object", {
  expect_true(all(lubridate::is.Date(cleaned_data$occ_date)))
})
