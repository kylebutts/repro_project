library(here)
source(here("logbook/render_file.R"))

# Data Cleaning ----------------------------------------------------------------
render_file("code/cleaning/clean_census.R")
render_file("code/cleaning/clean_shapefiles.R")








