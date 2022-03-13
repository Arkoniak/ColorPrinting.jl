function interpolate(s)
    isescape = false
    i1 = 1
    i2 = 1
    res = Expr(:string)
    while i2 <= ncodeunits(s)
        c = s[i2]
        if c == '\\'
            isescape = !isescape
            i2 = nextind(s, i2)
        elseif c == '$' && !isescape
            i1 != i2 && push!(res.args, s[i1:prevind(s, i2)])
            i2 = nextind(s, i2)
            data, i1 = Meta.parse(s, i2; greedy = false)
            i2 = i1
            push!(res.args, data)
        else
            isescape = false
            i2 = nextind(s, i2)
        end
    end

    i1 != i2 && push!(res.args, s[i1:prevind(s, i2)])
    return res
end

macro interpolate(s)
    esc(esc(interpolate(s)))
end
