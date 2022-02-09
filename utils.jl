using Artifacts: @artifact_str

function hfun_bar(vname)
    val = Meta.parse(vname[1])
    return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
    var = vname[1]
    return pagevar("index", var)
end

function lx_baz(com, _)
    # keep this first line
    brace_content = Franklin.content(com.braces[1]) # input string
    # do whatever you want here
    return uppercase(brace_content)
end

"""
    lx_readhtml(com, _)

Embed a Pluto notebook via:
https://github.com/rikhuijzer/PlutoStaticHTML.jl
"""
function lx_readhtml(com, _)
    file = string(Franklin.content(com.braces[1]))::String
    dir = joinpath("notebooks")
    html_path = joinpath(dir, "$file.html")
    jl_path = joinpath(dir, "$file.jl")

    return """
        ```julia:pluto
        # hideall

        using PlutoStaticHTML: notebook2html

        path = "$html_path"
        html = read(path, String)
        println("~~~\n\$html\n~~~\n")
        println("_To run this blog post locally, open [this notebook](/$jl_path) with Pluto.jl._")
        ```
        \\textoutput{pluto}
        """
end

"""
    hfun_artifact(params::Vector{String})::String

Return a (relative) URL to an artifact.
For example, for JuliaMono, use
```
{{artifact JuliaMono juliamono-0.042 webfonts JuliaMono-Regular.woff2}}
```
where JuliaMono is the name of the Artifact in Artifacts.toml.

This method copies the artifact, puts it into `_assets` and returns a relative URL.
"""
function hfun_artifact(params::Vector{String})::String
    name = params[1]
    dir = @artifact_str(name)
    from = joinpath(dir, params[2:end]...)
    @assert isfile(from)
    location = params[2:end]
    to = joinpath(@__DIR__, "__site", "assets", name, location...)
    mkpath(dirname(to))
    cp(from, to; force=true)
    parts = ["assets"; name; location]
    url = string('/', join(parts, '/'))
    return url
end

function hfun_menuitem(params::Vector{String})::String
    @assert length(params) == 2
    location, title = params

    rpath, _ = Franklin.LOCAL_VARS["fd_rpath"] # "tutorials/linear-model.md"
    current_location, _ = splitext(rpath)
    active = current_location == location ? "active" : ""

    pre = "<li class='menu-item $active'>"
    link = "<a href='/$location/'>$title</a>"
    post = "</li>"
    return string(pre, link, post)
end
