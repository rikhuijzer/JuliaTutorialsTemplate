+++
title = "Julia Tutorials Template"
tags = ["code", "tutorials"]
+++

# Julia Tutorials Template

This is an example website to create Julia tutorials.
To use this website as a template, go to
<https://github.com/rikhuijzer/JuliaTutorialsTemplate>
and click on **"Use this template"**.

## How does this template work?

On the left side, there is a list of example tutorials.
The tutorials all go through the following steps:

1. They are created and updated in [Pluto.jl](https://github.com/fonsp/Pluto.jl), which is super easy and convenient ✔️.
1. [PlutoStaticHTML.jl](https://github.com/rikhuijzer/PlutoStaticHTML.jl) takes the notebooks, runs them and converts them to Markdown files in parallel and with caching; for speed 🚀.
1. [Franklin.jl](https://github.com/tlienart/Franklin.jl) completes the job by making a pretty website from the Markdown files 😎.

## What alternatives are there to this template?

There is a template by Fons van der Plas at <https://github.com/JuliaPluto/static-export-template>.
That template is easier to use, sticks closer to the original Pluto appearance and has a link to a Binder for each notebook.
In contrast, this template provides more flexibility in appearance and is more suitable for people who like to style their output or who even want to hide all code.
Also, this template assumes some knowledge about GitHub Actions and hosting a website via GitHub Pages.

## How can I make my own tutorials?

1. Copy the [template](https://github.com/rikhuijzer/JuliaTutorialsTemplate).
1. Replace the Pluto notebooks (`.jl` files) inside `tutorials/` by your own tutorials.
1. Update the menu items to point to the right tutorials.
1. Modify any text however you like, the source code has an MIT license.
1. Profit.

