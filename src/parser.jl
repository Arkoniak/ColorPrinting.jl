struct Color
    c::Union{Symbol, Int}
end
Color() = Color(:normal)

struct Token
    s::String
    c::Color
end

function parsecolor(s, i)
    i >= ncodeunits(s) && return i, Color(), false
    i = nextind(s, i)
    i1 = i
    while i1 <= ncodeunits(s)
        c = s[i1]
        isspace(c) && return i, Color(), false
        if c == '{'
            i1 == i && return i, Color(), false
            val = s[i:prevind(s, i1)]
            v1 = tryparse(Int, val)
            i1 = nextind(s, i1)
            if v1 !== nothing
                return i1, Color(v1), true
            else
                return i1, Color(Symbol(val)), true
            end
        end
        i1 = nextind(s, i1)
    end

    return i, Color(), false
end

function parse!(s, i, res, col, depth)
    isescape = false
    i1 = i
    i2 = i
    while i2 <= ncodeunits(s)
        c = s[i2]
        if c == '\\'
            isescape = !isescape
        elseif c == ':' && !isescape
            i0, col2, iscol = parsecolor(s, i2)
            if iscol
                i1 < i2 && push!(res, Token(s[i1:prevind(s, i2)], col))
                i2 = parse!(s, i0, res, col2, 1)
                i1 = nextind(s, i2)
            end
        elseif c == '{' && !isescape
            depth += (depth > 0) # we do not calculate open and closed brackets for initial parse
        elseif c == '}' && !isescape
            depth -= (depth > 0)
            if depth == 0 
                push!(res, Token(s[i1:prevind(s, i2)], col))
                return i2
            end
        else
            isescape = false
        end
        i2 = nextind(s, i2)
    end
    
    i1 < i2 && push!(res, Token(s[i1:prevind(s, i2)], col))
    return i2
end

function parse(s)
    res = Token[]
    col = Color(:normal)
    parse!(s, 1, res, col, -1)

    return res
end

macro c_str(s)
    quote
        s2 = @interpolate $s
        parse(s2)
    end
end
