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

# %% 
#| results: 'hold'
1 + 1
mean(rnorm(1000))

#' ## Plots
# %% 
plot(mtcars$mpg, mtcars$hp)

#' ## Tables
# %% 
knitr::kable(
  mtcars[1:5, ], 
  caption = "A knitr kable."
)

#' ## Regression
# %%
est = feols(mpg ~ hp | cyl, mtcars)

# %%
esttable(est)
