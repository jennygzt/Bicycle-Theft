#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto package
# (Gelfand 2022)
# and saves the dataset for use in the main paper.
# Author: Zitong Guo
# Date: September 25, 2024
# Contact: jennygztong@gmail.com
# License: MIT
# Pre-requisites: Install the opendatatoronto (Gelfand 2022) and
# tidyverse packages.
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

##### Loading the datasets ####
# Search for a specific package on OpenDataToronto by keyword ("Bicycle Thefts")
Bicycle_Thefts_packages <- search_packages("Bicycle Thefts")
Bicycle_Thefts_packages
# Retrieve a list of all resources (datasets) available within the found package
Bicycle_Thefts_resources <- Bicycle_Thefts_packages %>%
  list_package_resources()
# Display the list of resources available in the "Marriage Licence Statistics"
# package
Bicycle_Thefts_resources

Bicycle_Thefts_statistics <- Bicycle_Thefts_resources[4, ] %>%
  get_resource()

#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(Bicycle_Thefts_statistics, "data/raw_data.csv")
