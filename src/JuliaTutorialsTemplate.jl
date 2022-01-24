module JuliaTutorialsTemplate

using PlutoStaticHTML

const PKGDIR = pkgdir(JuliaTutorialsTemplate)

export build_tutorials

const NOTEBOOK_DIR = joinpath(PKGDIR, "notebooks")

function copy_bindoutputs()
    notebook_files = filter(readdir(NOTEBOOK_DIR)) do file
        endswith(file, ".jl") && !startswith(file, PlutoStaticHTML.TMP_COPY_PREFIX)
    end
    for file in notebook_files
        name, _ = splitext(file)
        from_dir = joinpath(NOTEBOOK_DIR, name)
        to_dir = joinpath(PKGDIR, "__site", name)
        # Manually copying the files inside `from_dir` because Franklin creates an `index.html`.
        for indir in readdir(from_dir)
            from = joinpath(from_dir, indir)
            to = joinpath(to_dir, indir)
            cp(from, to; force=true)
        end
    end
end

"Build all the notebooks in parallel."
function build_notebooks()
    dir = NOTEBOOK_DIR
    bopts = BuildOptions(dir; store_binds=true)
    hopts = HTMLOptions(; append_build_context=true)
    parallel_build(bopts, hopts)
    return nothing
end

"Build the tutorials."
function build_tutorials()
    build_notebooks()
    copy_bindoutputs()
end

end # module
