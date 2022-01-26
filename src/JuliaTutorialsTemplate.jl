module JuliaTutorialsTemplate

using PlutoStaticHTML

const PKGDIR = pkgdir(JuliaTutorialsTemplate)

export build_tutorials

const TUTORIALS_DIR = joinpath(PKGDIR, "tutorials")

"Copy the source Markdown files, so that they can be inspected for debugging and used with caching."
function copy_markdown_files()
    from_dir = TUTORIALS_DIR
    md_files = filter(endswith(".md"), readdir(from_dir))
    to_dir = joinpath(PKGDIR, "__site", "tutorials")
    for md_file in md_files
        from = joinpath(from_dir, md_file)
        to = joinpath(to_dir, md_file)
        cp(from, to; force=true)
    end
    return nothing
end

"""
Franklin puts all HTML files inside a directory with the name "index.html".
This method unpacks that again.
"""
function unpack_html(dir)
    cd(dir) do
        dirs = filter(isdir, readdir(pwd()))
        for potential_packed_dir in dirs
            from = joinpath(potential_packed_dir, "index.html")
            to = potential_packed_dir * ".html"
            if isfile(from)
                cp(from, to; force=true)
            end
        end
    end
end

"Get files from a previous run. Assumes that the files are inside a `gh-pages` branch."
function previous_dir()
    if "DISABLE_CACHE" in keys(ENV) && ENV["DISABLE_CACHE"] == "true"
        return nothing
    end
    repo = ENV["REPO"]
    url = "https://github.com/$repo"
    dir = mktempdir()
    run(`git clone --depth=1 --branch=gh-pages $url $dir`)
    prev_dir = joinpath(dir, "tutorials")
    unpack_html(prev_dir)
    return prev_dir
end

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
    copy_markdown_files()
end

end # module
