# Reproducible Log Book

<div class="center">
  <a href='https://kylebutts.github.io/repro_project'><b>View live example logbook</b></a>
</div>

The goal of this project is to make it easy to create a reproducible logbook of your analysis pipeline using [quarto](https://quarto.org/). I want this to be additive, requiring *minimal* changes to your project. You don't need to change your project structure, change how you code, etc. 

Adding this to your project requires minimal changes to your code:

```diff
  .
  ├── README.md
  ├── ...
  ├── code
  │   ├── analysis
  │   │   └── main_analysis.R
  │   ├── cleaning
  │   │   └── clean_census.R
+ │   └── main.R
+ └── logbook
+    ├── analysis
+    │   └── main_analysis
+    │       ├── index.md
+    │       ├── index_files
+    │       │   └── ...
+    │       └── readme.md
+    ├── cleaning
+    │   └── clean_census
+    │       ├── index.md
+    │       └── readme.md
+    ├── render_file.R
+    ├── _quarto.yml
+    ├── copy_readme.R
+    └── index.md
```

First, add the `logbook` folder to your project. This folder contains the `quarto` configuration and `render_file.R` which creates a `render_file()` function for running and logging a script.

Logbook contents:
- `logbook/render_file.R` creates the `render_file()` function for logging script files. More details below.
- `logbook/_quarto.yml` is the quarto configuration file. You don't need to edit this.
- `README.md` is the "front page" to your project. This shows up when you open the github repository. 
- `logbook/copy_readme.R` gets run every time you use `quarto render` on the logbook to keep `index.md` up to date.

Second, you need to create a script similar to [`code/main.R`](https://github.com/kylebutts/repro_project/blob/main/code/main.R). It can be located anywhere. This scripts will create the reproduction pipeline and is just a list of calls to `render_file()` for each file. Calls should be ordered from top to bottom so that each file only depends on previously run scripts (i.e., a reproducible pipeline). 

*NOTE:* When working on the project, you don't need to rerun everything to update the logbook. Each file can be logged seperately. Though, it is good to check that everything is reproducible from time to time. 


## How `render_file()` works

The `render_file()` is basically a light wrapper around [`quarto::quarto_render()`](https://quarto.org/docs/prerelease/1.4/script.html).

This function takes a `.R`/`.py`/`.jl` script and renders it to a markdown log in the logbook folder. The `index.md` is what becomes the html page and the `readme.md` is what shows up on GitHub. #' This function renders the file only one time and points to the same files (e.g. any plots created), so the memory and compute costs of two versions is minimal. 

You can think of the `render_file()` as wrapping your code in one giant `.qmd` code chunk: 
````` md
``` r
...
```
`````

However, you can break your code up into chunks and write markdown right within the file. This isn't great for writing a paper, but it's great for small comments you want to display. Think of it like commenting your code in a way that presents nicely. 

### Code chunks

There is much more customization power possible using the `# %%` syntax. See for example, [`code/analysis/main_analysis.R`](https://github.com/kylebutts/repro_project/blob/main/code/analysis/main_analysis.R). This syntax is used in `.jl`/`.py`/`.R` files to denote code chunks and has editor support in VSCode. I love it because I can group lines of code that I want to run together in a chunk and in all three languages I can run them all together with one keyboard shortcut (I set up `cmd + shift + enter`).

When using `render_file()` (or `quarto::quarto_render()` directly), the `# %%` is converted to it's own code cell and you can pass options to it just like in `.qmd` files, e.g.:
``` r
# %% Chunk label
#| echo: false
#| warning: false
```

### Adding markdown into script

To insert markdown directly into your document (so that you can comment on your code):

- In `.R`, use roxygen style comments like this:
``` r
#' # Header
#'
#' Markdown text
```

- In `.py`/`.jl`, use raw string literals like this:
``` py
# %% [markdown]
"""
# Header

Markdown text
"""
```

### YAML Frontmatter

To render a script, quarto requires yaml frontmatter at the *top of your script*. The `render_file` script will insert a default one with a title field if it is not detected. The title will be based on the file name (e.g. `run_regressions.R` -> `Run Regressions`). *Note: you don't need to pass `format` since `render_file` handles this* 

You can add yaml frontmatter as a comment markdown like above. 

- In `.R`: 
``` r
#' ---
#' title: ''
#' ---
```

- In `.py`/`.jl`:
``` py
# %% [markdown]
# ---
# title: 'Great title'
# ---
```


### Deploying logbook

The logbook can be viewed on Github automatically just by clicking into folders (via the README.md file). However, deploying to a website requires some more setup. Since `logbook` is just a quarto project, deployment is just deploying a quarto project (from a non-root directory): https://quarto.org/docs/output-formats/html-publishing.html.

### README.md

At the base of your project (not the logbook), you should have a `README.md` file for your project. This file is copied over to the front page of the logbook via the `copy_readme.R` script. Below is a template that I use in my projects.


---
# Paper Title

[Kyle Butts](https://www.kylebutts.com/)<sup>1</sup>

<sup>1</sup>University of Colorado: Boulder

[Replication Material]() | Paper


## Abstract

Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

## Citation

```bib
@techreport{key,
  title={Paper Title},
  author={Butts, Kyle},
  year={20XX}
}
```


