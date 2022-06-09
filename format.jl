# Format the code and notebooks in this repository.
# This can be useful to make things more consistent.

using Pkg

Pkg.activate(; temp=true)
package = PackageSpec(; name="JuliaFormatter", version="0.22")
Pkg.add(package)

using JuliaFormatter
format(".")
