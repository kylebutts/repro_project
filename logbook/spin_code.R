#' Create a log of a file
#' 
#' @description
#' This takes a plain `.R` script, converts it to an `.Rmd` file using `knitr::spin()`, and then runs/logs using `rmarkdown::render()`. It takes a path to the `.R` file and creates an entry to `out_dir` using the same folder strucutre as the `.R file`. For example, if you have `file = "code/analysis/create_land_price_index.R"`, `out_base_dir = "logbook"` and `code_base_dir = "code"` it will create a logbook entry at `logbook/analysis/create_land_price_index.Rmd`.
#' 
#' File must start with yaml frontmatter containing a quarto markdown header.
#' These must be preceded by markdown comment blocks `#'`. 
#' For example:
#' ```
#' #' ---
#' #' format: gfm
#' #' ---
#' ```
#' 
#' @param file A `.R` script that you want to log results from. 
#' Can either be relative to `here::here()` or an absolute path.
#' @param out_base_dir The base directory for the logbook
#' @param code_base_dir The base directory for the code files. Relative paths will be taken relative to this directory.
#' @param format The format to render the `.qmd` file in. The default value is 
#' `"all"` which will render all formats specified in the frontmatter.
#' 
#' @return Nothing, but creates a log of the file
spin_file <- function(file, out_base_dir = "logbook", code_base_dir = "code") {
  
  # In case absolute path is given
  file = rm_base_dir(file, here::here())
  qmd_file = gsub(".R", ".qmd", file)
  
  # Create output directory 
  out_dir = here::here(
    out_base_dir, 
    file |> rm_base_dir(code_base_dir) |> path_ext_remove() 
  )
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

  # Read in file
  txt = xfun::read_utf8(here::here(file))
  
  # Step 1. 
  # Convert # Header ---- to #' ## Header
  # if (any(grepl("^(?<!#' )(#{1,})", txt))) {
  #   txt = gsub(
  #     "^(?<!#' )(#{1,}) (.*) -{4,}", 
  #     "#' \\1# \\2", 
  #     txt
  #   )
  # }

  # `.R` -> `.qmd`
  qmd_txt = knitr::spin(
    text = txt, format = "qmd", 
    report = TRUE, knit = FALSE
  )
  cat(
    paste0(qmd_txt, collapse = "\n"), 
    file = here::here(qmd_file)
  )

  # Move `.qmd` file to logbook for rendering
  qmd_file = gsub(".R", ".qmd", file)
  qmd_out_file = here::here(out_dir, "readme.qmd")
  file.rename(
    here::here(qmd_file), 
    qmd_out_file
  )
  return(invisible(NULL))
}

# Removes the base directory from a path
rm_base_dir <- function(dir, base_dir) {
  if (!grepl("/$", base_dir)) { 
    base_dir = paste0(base_dir, "/")
  }
  gsub(base_dir, "", dir)
}

# Remove path extension
path_ext_remove <- function(file) {
  sub("\\.[a-zA-Z0-9]*$", "", file)
}

spin_files <- function(out_base_dir = "logbook", code_base_dir = "code") {
  files = list.files(
    here::here(code_base_dir), 
    pattern = "\\.R$", 
    recursive = TRUE, 
    full.names = TRUE
  )
  for (file in files) {
    spin_file(file, out_base_dir, code_base_dir)
  }
}

# TODO: Don't copy over files that haven't changed
# spin_files()


