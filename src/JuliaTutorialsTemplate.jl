module JuliaTutorialsTemplate

using PlutoStaticHTML

const PKGDIR = pkgdir(JuliaTutorialsTemplate)

export build_tutorials

const TUTORIALS_DIR = joinpath(PKGDIR, "tutorials")

"Add a link to the notebook at the bottom of each tutorial."
function append_notebook_links()
    dir = TUTORIALS_DIR
    md_paths = filter(endswith(".md"), readdir(dir; join=true))
    for md_path in md_paths
        md_file = basename(md_path)
        without_extension, _ = splitext(md_file)
        jl_file = "$(without_extension).jl"
        url = "/tutorials/$jl_file"
        open(md_path, "a") do io
            text = """\n
                _To run this tutorial locally, download [this file]($url) and open it with
                [Pluto.jl](https://plutojl.org)._
                """
            write(io, text)
        end
    end
    return nothing
end

"Build all the notebooks in parallel."
function build_notebooks()
    dir = TUTORIALS_DIR
    bopts = BuildOptions(dir; output_format=franklin_output)
    hopts = HTMLOptions(; append_build_context=true)
    parallel_build(bopts, hopts)
    return nothing
end

"Build the tutorials."
function build_tutorials()
    build_notebooks()
    append_notebook_links()
end

end # module
