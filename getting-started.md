+++
title = "Getting started"
+++

# Getting started

This page contains some detailed instructions on creating your own website with Julia tutorials.
If you are more familiar with Julia development and GitHub Actions and Pages, then see the [Homepage](/) for more generic instructions.

\toc

## Create a new repository based on this template

Before diving into details, a bit of background about the build system:
GitHub provides computers for free to run your code or, specifically, tutorials **and** they host websites for free.
This running for free is called continuous integration (CI) and is very useful in practice.
In essence, the idea is that a computer starts running your code each time that you change your code/tutorials in a repository.
Because GitHub shows very clearly which runs belong to which code change, it is very easy to see what caused runs to fail if a mistake was made when updating a tutorial.
Also, CI contains the whole build pipeline from [Pluto.jl](https://github.com/fonsp/Pluto.jl) notebooks to deploying the website.
This makes it easy to make a minor change, say, to fix a typo.
Instead of manually having to run the tutorial after fixing the typo and upload the changed files to a website, the idea is to just fix the typo and let CI do the rest.
The CI will automatically re-run any notebooks that it needs to run and update the website.

So, to have your own tutorials and CI and website, a new repository has to be created based on this template.
To do so, go to <https://github.com/rikhuijzer/JuliaTutorialsTemplate> and click on the big "Use this template" button.
In the new page that opens, give your project a nice name click on "Create repository from template".
Do not select "Include all branches".
Next, GitHub will say "Generating your repository" for a few seconds and then you have your new repository 🎉.

## Check that GitHub Actions are running

That CI thing mentioned above is called GitHub Actions.
When clicking on the Actions tab near the top of the page, there should be one workflow run visible.
It should either be orange, which means running, or green, which means successfully finished.
If this is the case, then you're ready to go to the next step 🎈.
Otherwise, enable the GitHub Actions in the repository settings or open an issue at <https://github.com/rikhuijzer/JuliaTutorialsTemplate/issues/new>.

## Enable the website

To setup the website go to your Pages settings inside your repository's settings.
This should show "Your site is ready to be published at [...]".
To publish the site, set the Source to `gh-pages` and click Save.
After a few minutes, your site should be visible at the link shown after "Your site is ready to be published at".
So, that's probably something like "https://YourName.github.io/YourProject" 🌐.
If you want, you can add this link to the About section on the homepage of your GitHub repository so that you and visitors can quickly find the site from there.

## Make the website your own

Now that all automation is configured, you can change the files in the repository and the site should update once the run completes.
There are now two ways to go about changing the website:

### Without running the site locally

Just create some new Pluto notebooks and store them in the `tutorials` directory.
Note that the page title is set in the first blocks looking like:

```
# hideall
title = "My title";
```

```
"""
+++
title = "$title"
+++
""" |> Base.Text
```

Add these blocks in your website to let Franklin know what the page title should be.
Also remove the old tutorials while you are in that folder.

Next, search for `JuliaTutorialsTemplate` inside your repository and replace all occurrences of that word by the name of your repository.
It is especially important to set the right `prepath` in `config.md` since otherwise the CSS will not work on the website.

Also, go to the menu in `_layout/menu.html` and find the lines containing "menu-header" and "menu-item".
Compare these lines with how the website looks and, next, change the lines to point to your own tutorials.
You can also decide to remove all "menu-header" entries; it depends on personal preference.

After doing this, your tutorials should become available on your website 🔎.
This approach should work fine in most cases 🧑‍💻.
If there are problems, it may be good to run the site locally to see what's wrong.

### With running the site locally

If you rather double check whether things work locally, there are two things to do:

First, run the following:

```julia-repl
julia> ]

pkg> activate .

(Tutorials) pkg> instantiate

(Tutorials) pkg> # Press backspace to go back

julia> using Tutorials

julia> build_tutorials()
[...]
```

This should run all the tutorials in the `tutorials` folder and write multiple Markdown files to the `tutorials` folder.
Now that the files can be read by [Franklin.jl](https://github.com/tlienart/Franklin.jl), it's time to start the Live Server.
To do so, continue from the last code with:

```julia-repl
julia> using Franklin

julia> serve()
[...]
→ Starting the server...
✓ LiveServer listening on http://localhost:8000/ ...
  (use CTRL+C to shut down)
→ page updated [✓]
```

Go to that URL (`http://localhost:8000/`) in your browser to see a preview of the tutorials.

