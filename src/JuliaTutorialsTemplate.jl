module JuliaTutorialsTemplate

using PlutoStaticHTML

const PKGDIR = pkgdir(JuliaTutorialsTemplate)

export build_tutorials

const TUTORIALS_DIR = joinpath(PKGDIR, "tutorials")

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
end

end # module
