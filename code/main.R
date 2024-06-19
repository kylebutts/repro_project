#' # Main script to run the complete project
#' 
#' `render_file` will run the R file and log the results of the script 
#' in the `logbook`. The logbook can be viewed with 
#' `quarto preview logbook` from the terminal.
library(here)
library(fs)
library(sessioninfo)
source(here("logbook/render_file.R"))

library(tictoc)
tic.clearlog()

# Data Cleaning ----------------------------------------------------------------
tic("Data Cleaning")
render_file("code/cleaning/clean_census.R")
toc(log = TRUE)

# Analysis ---------------------------------------------------------------------
tic("Analysis")
1 && render_file("code/analysis/main_analysis.R")
0 && render_file("code/analysis/plot_in_julia.jl")
1 && render_file("code/analysis/python_code.py")
toc(log = TRUE)



# Print out replication details ------------------------------------------------
fs::dir_create(here("logbook/replication_info/"))
sink(file = here("logbook/replication_info/index.md"))
cat("# Code runtimes:")
temp <- lapply(
  tic.log(format = FALSE), 
  function(tictoc) {
    cat("\n-", format_tictoc_msg(tictoc))
  }
)

cat("\n\n# Session Info:\n\n```\n")
sessioninfo::session_info()
cat("```")
sink()


