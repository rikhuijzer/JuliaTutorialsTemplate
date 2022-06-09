### A Pluto.jl notebook ###
# v0.18.4

using Markdown
using InteractiveUtils

# ╔═╡ d7967150-5a59-4199-83ad-4e79476c0d44
using PlutoUI: with_terminal

# ╔═╡ 1a45c71a-4204-461b-8f85-61d9a79f8cf8
using BenchmarkTools

# ╔═╡ bdacad08-a9b1-11ec-1013-45393b4e19c9
# hideall
title = "Benchmarking";

# ╔═╡ 031e949e-e784-4d9d-b767-0a3e2d29d3a2
"""
+++
title = "$title"
+++
""" |> Base.Text

# ╔═╡ 8a859941-0f2d-45fb-b56b-a3f58f97a36a
md"""
# $title

This notebook shows some `@benchmark` and `@code_warntype` output.
Both outputs are shown via the `with_terminal` from [PlutoUI.jl](https://github.com/JuliaPluto/PlutoUI.jl), see below.

We define some function `double` and a dictionary of numbers in order to show type inference problems via `@code_warntype`:
"""

# ╔═╡ 90cb7685-09fc-4f2a-88c9-64fada9e50d0
numbers = Dict(:one => 1f0, :two => 2.0)

# ╔═╡ 3f0e2049-8597-4dac-b499-4d7a8a35978e
function double(mapping, key::Symbol)
    return 2 * mapping[key]
end;

# ╔═╡ faef1ae5-eeac-4e23-ba75-23ae2f1ca629
md"""
Now, the code works.
"""

# ╔═╡ a3c923e5-2873-48a2-ad0f-0087585136a7
double(numbers, :one)

# ╔═╡ a16c4a67-8666-4dc5-b100-4c2c7c51f981
double(numbers, :two)

# ╔═╡ 187e21bc-db38-48c9-97cd-7894685e1b43
md"""
But the `@code_warntype` shows some big red warnings:
"""

# ╔═╡ a3b4bcc6-4aa1-48b2-b598-0613794beab2
with_terminal() do
    @code_warntype double(numbers, :one)
end

# ╔═╡ 8c147812-f0e7-4b14-9082-3ac4d5f07000
md"""
We can fix this by forcing all elements in the dictionary to have the same type.
Specifically, to we force all elements to be of type `Float64`:
"""

# ╔═╡ 0f78717a-ccbd-4af1-a150-adcce25cddb4
typednumbers = Dict{Symbol, Float64}(:one => 1f0, :two => 2.0)

# ╔═╡ 48d6f2fa-04e8-475c-92b6-43418f6a2c6c
md"""
This gets rid of all the type warnings:
"""

# ╔═╡ c678d759-9a68-439e-9cb3-3cfe94088794
with_terminal() do
    @code_warntype double(typednumbers, :one)
end

# ╔═╡ 3cf79c82-9d43-41d3-b968-e2d283bc32ea
md"""
And makes the method more quick:
"""

# ╔═╡ b52f7449-aed4-4eba-905f-3c078fba4f3f
md"""
## Appendix
"""

# ╔═╡ 064395ff-2cc6-4be1-a6f0-0c3ccefdf8ce
function with_benchmark_terminal(f)
    out = sprint(show, "text/plain", f())
    with_terminal() do
        print(out)
    end
end;

# ╔═╡ bc815bd5-1f5e-4641-81f4-80e0306398bf
with_benchmark_terminal() do
    @benchmark double(numbers, :one)
end

# ╔═╡ b8f4d737-4647-47f1-8c45-c3ed30994e1f
with_benchmark_terminal() do
    @benchmark double(typednumbers, :one)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
BenchmarkTools = "~1.3.1"
PlutoUI = "~0.7.37"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "4c10eee4af024676200bc7752e536f858c6b8f93"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "bf0a1121af131d9974241ba53f601211e9303a9e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.37"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═bdacad08-a9b1-11ec-1013-45393b4e19c9
# ╠═031e949e-e784-4d9d-b767-0a3e2d29d3a2
# ╠═8a859941-0f2d-45fb-b56b-a3f58f97a36a
# ╠═90cb7685-09fc-4f2a-88c9-64fada9e50d0
# ╠═3f0e2049-8597-4dac-b499-4d7a8a35978e
# ╠═faef1ae5-eeac-4e23-ba75-23ae2f1ca629
# ╠═a3c923e5-2873-48a2-ad0f-0087585136a7
# ╠═a16c4a67-8666-4dc5-b100-4c2c7c51f981
# ╠═187e21bc-db38-48c9-97cd-7894685e1b43
# ╠═d7967150-5a59-4199-83ad-4e79476c0d44
# ╠═a3b4bcc6-4aa1-48b2-b598-0613794beab2
# ╠═8c147812-f0e7-4b14-9082-3ac4d5f07000
# ╠═0f78717a-ccbd-4af1-a150-adcce25cddb4
# ╠═48d6f2fa-04e8-475c-92b6-43418f6a2c6c
# ╠═c678d759-9a68-439e-9cb3-3cfe94088794
# ╠═3cf79c82-9d43-41d3-b968-e2d283bc32ea
# ╠═1a45c71a-4204-461b-8f85-61d9a79f8cf8
# ╠═bc815bd5-1f5e-4641-81f4-80e0306398bf
# ╠═b8f4d737-4647-47f1-8c45-c3ed30994e1f
# ╠═b52f7449-aed4-4eba-905f-3c078fba4f3f
# ╠═064395ff-2cc6-4be1-a6f0-0c3ccefdf8ce
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
