#### Preamble ####
# Purpose: Cleans the raw Toronto healthcare outbreaks dataset obtained in
# "01-download_data.R".
# Author: Zitong Guo
# Date: September 25, 2024
# Contact: jennygztong@gmail.com
# License: MIT
# Pre-requisites: Run the file "01-download_data.R".
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Clean data ####
# Load the raw data
raw_data <- read_csv("data/raw_data.csv")

# Clean and rename locations
cleaned_data <-
  raw_data |>
  janitor::clean_names() |> # Clean column names (lowercase and underscores)
  filter(!is.na(bike_cost), !is.na(status)) |>
  # Remove rows with missing bike cost or status
  mutate(
    bike_cost = if_else(bike_cost < 0, NA_real_, bike_cost),
    # Remove any negative bike costs
    occ_date = lubridate::ymd(occ_date), # Convert occ_date to a date object
    occ_year = as.integer(occ_year), # Ensure occ_year is an integer
    occ_month = factor(occ_month, levels = month.name), # Convert occ_month to
    # a factor with proper month order
    status = str_to_upper(status), # Standardize the status values to uppercase

    # Rename the locations
    location_type = case_when(
      location_type == "Apartment (Rooming House, Condo)" ~ "Apartment",
      location_type == "Single Home, House (Attach Garage,
      Cottage, Mobile Home)" ~ "House",
      location_type == "Other Commercial / Corporate Places (For Profit,
      Warehouse)" ~ "Commercial",
      location_type == "Streets, Roads, Highways (Bicycle Path,
      Private Roads)" ~ "Street/Road",
      location_type == "Parking Lots, Open Areas (Parks)" ~ "Parking Lot/Park",
      TRUE ~ location_type # Keep original name if no match
    )
  ) |>
  select(location_type, bike_cost, status, occ_date, occ_year, occ_month) |>
  # Select important columns
  tidyr::drop_na() # Remove any remaining rows with missing values

#### Save data ####
# Save the cleaned and renamed data
write_csv(cleaned_data, "data/cleaned_data.csv")

#### Summary ####
# View the first few rows of the cleaned and renamed data
head(cleaned_data)

# Print a summary of the cleaned data
summary(cleaned_data)
write_csv(cleaned_data, "data/cleaned_data.csv")
