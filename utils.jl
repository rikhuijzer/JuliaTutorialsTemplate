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
