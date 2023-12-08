[**View live example logbook**](https://kylebutts.github.io/repro_project)

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

# About this project

## Directory structure

This is the structure of a project that I'm really happy with. I do all my coding in the `code/` folder using basic `.R` files and the `# %%` syntax for code chunks (I do not really like working in `.qmd` files). However, I like the ability to run something and produce a log of graphs/output/tables that I run. This is good for sharing with coauthors and the reports can be run to make sure that the output is still the same. 

The `# %%` style actually converts to a `.qmd` file with the `knitr::spin()` command (see details in the [R Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/spin.html)). I have a script `render_file.R` that takes `.R` files in the `code/` folder and converts them to `.qmd` scripts and then renders them to a `.md` file in the `logbook/` folder, following the same folder structure as in `code/`. 

The logbook is a quarto website that lets you view the log in a nice website (see the live example above). This produces an `index.md` which will render to html and a `readme.md` which will be viewable on github. It can be deployed in various ways: https://quarto.org/docs/output-formats/html-publishing.html.

## `code/main.R`

The file [`code/main.R`](https://github.com/kylebutts/repro_project/blob/main/code/main.R) is the reproduction starting point. I write the files in the order they would need to be run to *completely* redo the analysis. Files are run in order from top to bottom, so you should structure it in a way where each file only depends on previously run scripts. 

When working on the project, you don't need to rerun everything to update the logbook, but it's good to check that everything is reproducible from time to time. 


