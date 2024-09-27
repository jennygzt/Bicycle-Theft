#### Preamble ####
# Purpose: Generates a simulated version of the Toronto bicycle theft dataset
# and uses tests to ensure that the simulated data is reasonable and realistic
# Author: Zitong Guo
# Date: September 25, 2024
# Contact: jennygztong@gmail.com
# License: MIT
# Pre-requisites: Install tidyverse
# Any other information needed? NONE


# Load necessary libraries
library(tidyverse)
library(dplyr)
library(lubridate)

# Set seed for reproducibility
set.seed(666)

# Number of rows to simulate
n <- 1000

# Simulate LOCATION_TYPE based on observed frequencies
location_types <- c(
  "Apartment", "House", "Commercial", "Street/Road", "Park",
  "Other"
)
location_probs <- c(0.25, 0.20, 0.15, 0.25, 0.10, 0.05)
# Set probabilities for each type
simulated_location <- sample(location_types,
  size = n, replace = TRUE,
  prob = location_probs
)

# Simulate BIKE_COST (assuming some general distribution based on observed data)
simulated_bike_cost <- round(rnorm(n, mean = 600, sd = 300), 2)
# Normal distribution for cost

# Simulate STATUS (STOLEN or RECOVERED)
status_types <- c("STOLEN", "RECOVERED")
simulated_status <- sample(status_types,
  size = n, replace = TRUE,
  prob = c(0.7, 0.3)
)

# Simulate OCC_YEAR (randomly between 2010 and 2023)
simulated_year <- sample(2010:2023, size = n, replace = TRUE)

# Simulate OCC_MONTH (randomly between January and December)
simulated_month <- sample(month.name, size = n, replace = TRUE)

# Simulate OCC_DATE (combine year, month, and a random day)
simulated_date <- ymd(paste(simulated_year, match(simulated_month, month.name),
  sample(1:28, size = n, replace = TRUE),
  sep = "-"
))

# Create a data frame with the simulated data
simulated_data <- data.frame(
  LOCATION_TYPE = simulated_location,
  BIKE_COST = simulated_bike_cost,
  STATUS = simulated_status,
  OCC_DATE = simulated_date,
  OCC_YEAR = simulated_year,
  OCC_MONTH = simulated_month
)

# View the first few rows of the simulated data
head(simulated_data)
