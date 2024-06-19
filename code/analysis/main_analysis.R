#' ---
#' title: "Main analysis script"
#' ---

#' This is an example script that will be run by `render_file` and logged in 
#' the logbook.
#' 
#' ::: {.callout-note}
#' Note that there are five types of callouts, including:
#' `note`, `warning`, `important`, `tip`, and `caution`.
#' :::

# %% 
#| message: false
#| warning: false
library(tidyverse, warn.conflicts = FALSE)
library(fixest)
library(tinytable)

# %% Test label
#| results: 'hold'
1 + 1
mean(rnorm(1000))

#' ## Plots
# %% 
plot(mtcars$mpg, mtcars$hp)

#' ## Tables
# %% 
tinytable::tt(
  mtcars[1:5, ], 
  caption = "First five rows of `mtcars`"
)

#' ## Regression
# %%
est = feols(mpg ~ hp | cyl, mtcars)
esttable(est)
