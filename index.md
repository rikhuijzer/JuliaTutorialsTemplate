+++
title = "Homepage"
tags = ["code", "tutorials"]
+++

# JuliaTutorialsTemplate

**WORK IN PROGRESS. BETA STAGE.**
**I'm working on this to improve stability and functionality.**

This is an example website to create Julia tutorials and it can be used as a template:
<https://github.com/rikhuijzer/JuliaTutorialsTemplate>.

## How does this template work?

On the left side, there is a list of example tutorials.
The tutorials all go through the following steps:

1. They are created and updated in [Pluto.jl](https://github.com/fonsp/Pluto.jl) notebooks, which is super easy and convenient ✔️.
1. [PlutoStaticHTML.jl](https://github.com/rikhuijzer/PlutoStaticHTML.jl) takes the notebooks, runs them and converts them to Markdown files in parallel and with caching; for speed 🚀.
1. [Franklin.jl](https://github.com/tlienart/Franklin.jl) completes the job by making a pretty website from the HTML files 😎.

## What alternatives are there to this template?

- There is a template by Fons van der Plas at <https://github.com/JuliaPluto/static-export-template>.
    That template is easier to use, sticks closer to the original Pluto appearance and has a link to a Binder for each notebook.
    This template provides more flexibility in appearance and is more suitable for people who like to style their output or who even want to hide all code.

## How can I make my own tutorials?

1. Copy the [template](https://github.com/rikhuijzer/JuliaTutorialsTemplate).
1. Replace the Pluto notebooks (`.jl` files) inside `tutorials/` by your own tutorials.
1. Update the menu items to point to the right tutorials.
1. Replace my name, `JuliaTutorialsTemplate` and the repository name by your preferences.
1. Profit.
