# Reproducible Research Workflow

This is the structure of a project that I'm really happy with. I do all my coding in the `code/` folder using basic `.R` files and the `# %%` syntax for code chunks (I do not really like working in `.qmd` files). However, I like the ability to run something and produce a log of graphs/output/tables that I run. This is good for sharing with coauthors and the reports can be run to make sure that the output is still the same. 

I want this to be automated. So what do I do? I have a `logbook/` folder that contains a Quarto Website. This is nice because `.qmd` files will only be rerun when they're out of date, making it so I can update the site quickly. 

The `# %%` style actually converts to a `.qmd` file with the `knitr::spin()` command. So I have a script `spin_code.R` that takes `.R` files in the `code/` folder and converts them to `.qmd` files in the `logbook/` folder, following the same folder structure. 

The only thing to update is the `_quarto.yml` file to include the new `.qmd` files in the `sidebar` option. Files are run in order from top to bottom, so you should structure it in a way where each file only depends on previously run scripts.

The website can be deployed with github pages quite easily following this guide: https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site.
