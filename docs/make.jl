using ColorPrinting
using Documenter

DocMeta.setdocmeta!(ColorPrinting, :DocTestSetup, :(using ColorPrinting); recursive=true)

makedocs(;
    modules=[ColorPrinting],
    authors="Andrey Oskin",
    repo="https://github.com/Arkoniak/ColorPrinting.jl/blob/{commit}{path}#{line}",
    sitename="ColorPrinting.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Arkoniak.github.io/ColorPrinting.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Arkoniak/ColorPrinting.jl",
    devbranch="main",
)
