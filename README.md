<div class="center">
  <a href='https://kylebutts.github.io/repro_project'><b>View live example logbook</b></a>
</div>

# Reproducible Log Book

The goal of this project is to make it easy to create a reproducible logbook of your analysis pipeline using [quarto](https://quarto.org/). I want this to be additive, requiring *minimal* changes to your project. You don't need to change your project structure, change how you code, etc. Instead, you just need to do the following:

1. Copy the `logbook` folder to your project. This folder contains the `quarto` configuration and `render_file.R` which creates a function for running and logging a script. 

2. You need to create a script similar to [`code/main.R`](https://github.com/kylebutts/repro_project/blob/main/code/main.R). This scripts will create the reproduction pipeline. This file is basically just a list of calls to `render_file()` instead of calls to `source()`. Calls should be ordered from top to bottom so that each file only depends on previously run scripts. 

>[!NOTE]
> When working on the project, you don't need to rerun everything to update the logbook. Each file can be logged seperately. Though, it is good to check that everything is reproducible from time to time. 


## Directory Structure

Here is the example directory structure. Note how the folder structure in `logbook` matches the folder structure in `code`. This handled by the `render_file()` function. 

```
.
├── README.md
├── code
│   ├── analysis
│   │   └── main_analysis.R
│   ├── cleaning
│   │   └── clean_census.R
│   └── main.R
└── logbook
    ├── analysis
    │   └── main_analysis
    │       ├── index.md
    │       ├── index_files
    │       │   └── ...
    │       └── readme.md
    ├── cleaning
    │   └── clean_census
    │       ├── index.md
    │       └── readme.md
    ├── render_file.R
    ├── _quarto.yml
    ├── copy_readme.R
    └── index.md
```

Addtional files:
- `logbook/render_file.R` is the script that runs a script and logs it. More details below.
- `logbook/_quarto.yml` is the quarto configuration file. You don't need to edit this.
- `README.md` is the "front page" to your project. This shows up when you open the github repository. 
- `logbook/copy_readme.R` gets run every time you use `quarto render` on the logbook to keep `index.md` up to date.


## How `render_file()` works

The `render_file()` is basically a light wrapper around [`quarto::quarto_render()`](https://quarto.org/docs/prerelease/1.4/script.html). What it does is as follows:

1. It takes a `.R` file (`.py`/`.jl` soon!), converts it to a `.qmd` file. See the YAML Frontmatter section for important details.
2. It renders the `.qmd` file to a `index.md` and to `readme.md` in the logbook folder. The `index.md` is what becomes the html page and the `readme.md` is what shows up on GitHub. This only requires rendering the script once.

You can think of the `render_file()` as wrapping your code in one giant `.qmd` code chunk: 
`````
```{r}
...
```
`````

However, you can do anything you can in a `.qmd` file in a plain script... 

### Code chunks

There is much more customization power possible using the `# %%` syntax. See for example, [`code/analysis/main_analysis.R`](https://github.com/kylebutts/repro_project/blob/main/code/analysis/main_analysis.R). This syntax is used in `.jl`/`.py`/`.R` files to denote code chunks and has editor support in VSCode. I love it because I can group lines of code that I want to run together in a chunk and in all three languages I can run them all together with one keyboard shortcut (I set up `cmd + shift + enter`).

When using `render_file()` (or `quarto::quarto_render()` directly), the `# %%` is converted to it's own code cell and you can pass options to it just like in `.qmd` files, e.g.:
```r
# %% Chunk label
#| echo: false
#| warning: false
```

### Adding markdown into script

To insert markdown directly into your document (so that you can comment on your code):

- In `.R`, use roxygen style comments like this:
```
#' # Header
#'
#' Markdown text
```

- In `.py`/`.jl`, use raw string literals like this:
```
# %% [markdown]
"""
# Header

Markdown text
"""
```


### YAML Frontmatter
The only modification to your file is you need to include yaml frontmatter at the *top of your script*. Note, you don't need to pass `format` since `render_file` handles this. 

You can add yaml frontmatter as a comment markdown like above. 

- In `.R`: 
```
#' ---
#' title: ''
#' ---
```

- In `.py`/`.jl`:
```
# %% [markdown]
"""
---
title: ''
---
"""
```


### Deploying logbook

The logbook can be viewed on Github automatically just by clicking into folders (via the README.md file). However, deploying to a website requires some more setup. Since `logbook` is just a quarto project, deployment is just deploying a quarto project (from a non-root directory): https://quarto.org/docs/output-formats/html-publishing.html.


### TODOS

1. Automatically add YAML frontmatter with `title: 'script_name'` if yaml is missing.
2. Add support for `.py` and `.jl` files.

PRs welcome!


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


