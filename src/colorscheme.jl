struct ColorScheme
    cs::Dict{Symbol, Union{Int, Symbol}}
end
ColorScheme() = ColorScheme(Dict())
ColorScheme(ps::Pair...) = ColorScheme(Dict(ps...))

Base.getindex(cs::ColorScheme, key) = get(cs.cs, key, key)

function Base.print(io::IO, tokens::Vector{Token})
    for token in tokens
        printstyled(io, token.s; color = token.c.c)
    end
end

Base.print(io::IO, cs::ColorScheme, xs...) = Base.print(IOContext(io, :colorscheme => cs), xs...)

function Base.print(ioc::IOContext, tokens::Vector{Token})
    cs = get(ioc, :colorscheme, ColorScheme())
    for token in tokens
        printstyled(ioc, token.s; color = cs[token.c.c])
    end
end
