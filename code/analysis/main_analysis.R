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
1 + 1

# %% 
plot(mtcars$mpg, mtcars$hp)

# %% 
knitr::kable(
  mtcars[1:5, ], 
  caption = "A knitr kable."
)

# %%
est = feols(mpg ~ hp | cyl, mtcars)

# %%
esttable(est)
