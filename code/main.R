#' # Main script to run the complete project
#' 
#' `render_file` will run the R file and log the results of the script 
#' in the `logbook`. The logbook can be viewed with 
#' `quarto preview logbook` from the terminal.
library(here)
source(here("logbook/render_file.R"))

# Data Cleaning ----------------------------------------------------------------
render_file("code/cleaning/clean_census.R")

# Analysis ---------------------------------------------------------------------
render_file("code/analysis/analysis.R")

