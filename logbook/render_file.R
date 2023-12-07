#' Create a `.qmd` log of an `.R` file
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
render_file <- function(file, out_base_dir = "logbook", code_base_dir = "code", format = "gfm") {
  
  # In case absolute path is given
  orig_file = file
  file = fs::path_rel(file, here::here())
  file_dir = dirname(file)
  
  # Make temp folder to create readme.md
  temp_dir = paste0(file_dir, "/temp")
  fs::dir_create(here::here(temp_dir))

  qmd_file = here::here(temp_dir, "index.qmd")
  md_file = here::here(temp_dir, "index.md")
  md_file_folder = here::here(temp_dir, "index_files")

  out_dir = here::here(
    out_base_dir, 
    file |> fs::path_rel(code_base_dir) |> fs::path_ext_remove() 
  )

  # Read in file
  txt = xfun::read_utf8(here::here(file))
  
  # Convert # Header ---- to #' ## Header
  regex_header = "^(#{1,})\\s(.*)-{4,}"
  txt = gsub(
    regex_header, 
    "#' \\1# \\2", 
    txt
  )

  # `.R` -> `.qmd`
  qmd_txt = knitr::spin(
    text = txt, format = "qmd", 
    report = TRUE, knit = FALSE
  )
  cat(
    paste0(qmd_txt, collapse = "\n"), 
    file = qmd_file
  )

  # TODO: Don't run if not needed !!!
  # Render to gfm
  quarto::quarto_render(
    qmd_file,
    output_format = "gfm",
    execute_dir = here::here()
  )

  # Create output directory in logbook 
  fs::dir_create(out_dir)
  out_dir_files = here::here(out_dir, "index_files")
  
  if (fs::dir_exists(out_dir_files)) fs::dir_delete(out_dir_files)
  
  fs::dir_create(out_dir_files)
  fs::file_copy(
    md_file, 
    here::here(out_dir, "index.md"),
    overwrite = TRUE
  )
  if (fs::dir_exists(md_file_folder)) {
    fs::file_move(
      md_file_folder, 
      here::here(out_dir)
    )
  }

  # TODO: Option to not delete `.qmd` file
  fs::dir_delete(temp_dir)

  return(invisible(NULL))
}