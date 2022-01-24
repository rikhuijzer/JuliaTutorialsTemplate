+++
title = "Homepage"
tags = ["code", "tutorials"]
+++

# JuliaTutorialsTemplate

**WORK IN PROGRESS. BETA STAGE.**
**I'm working on this to improve stability and functionality.**

This is an example website to create Julia tutorials and it can be used as a template:
<https://github.com/rikhuijzer/JuliaTutorialsTemplate>.

## How does this work?

On the left side, there is a list of example tutorials.
The tutorials all go through the following steps:

1. They are created and updated in [Pluto.jl](https://github.com/fonsp/Pluto.jl) notebooks, which is super easy and convenient ✔️.
1. [PlutoStaticHTML.jl](https://github.com/rikhuijzer/PlutoStaticHTML.jl) takes the notebooks and converts them to HTML files in parallel and uses caching; for speed 🚀.
1. [Franklin.jl](https://github.com/tlienart/Franklin.jl) completes the job by making a pretty website from the HTML files 😎.

## How can I make my own tutorials?

1. Copy the [template](https://github.com/rikhuijzer/JuliaTutorialsTemplate).
1. Replace the Pluto notebooks (`.jl` files) inside `tutorials/` by your own tutorials.
1. Update the menu items to point to the right tutorials.
1. Replace `JuliaTutorialsTemplate` and my name by your own.
1. Profit.
