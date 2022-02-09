### Preamble ###
# Purpose: import data about bike theft in Toronto using opendatatoronto
# Author: Dai Moroi
# Contact: dai.moroi@mail.utoronto.ca
# Date: 2022-02-04

### Workspace setup ###
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("opendatatoronto")) install.packages("opendatatoronto")
if (!require("janitor")) install.packages("janitor")
library(tidyverse)
library(opendatatoronto)
library(janitor)



###Import data###
# Data is available here: https://open.toronto.ca/dataset/bicycle-thefts/
raw_data <- 
  list_package_resources("c7d34d9b-23d2-44fe-8b3b-cd82c8b38978") |>
  filter(name == "bicycle-thefts") |>
  get_resource()

write_csv(
  x = raw_data,
  file = "bicycle-thefts_csv"
)

###Read in data###
bicycle_thefts <-
read_csv(
  file = "bicycle-thefts.csv",
  show_col_types = FALSE)

###Clean data###
#clean names
cleaned_data <-
  bicycle_thefts |>
  clean_names() |>
  select(id, occurrence_date, occurrence_year, occurrence_month, occurrence_day_of_week, occurrence_hour, neighbourhood_name, premises_type) |> #select necessary columns
  filter(occurrence_year %in% c(2014:2020))  #we don't need data not from 2014-2020, because the data started being collected from 2014 and those from earlier than 2014 are very few in numbers
  

write_csv(
  x = cleaned_data,
  file = "cleaned_data.csv"
  )

raw_population <-
  list_package_resources("6e19a90f-971c-46b3-852c-0c48c436d1fc") |>
  filter(name == "neighbourhood-profiles-2016-csv") |>
  get_resource()

population <-
  raw_population |>
  slice(3)

write_csv(
  x = population,
  file = "population.csv"
)

