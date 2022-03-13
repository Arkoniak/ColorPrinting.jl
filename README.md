# ColorPrinting

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Arkoniak.github.io/ColorPrinting.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://Arkoniak.github.io/ColorPrinting.jl/dev)
[![Build Status](https://github.com/Arkoniak/ColorPrinting.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Arkoniak/ColorPrinting.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/Arkoniak/ColorPrinting.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/Arkoniak/ColorPrinting.jl)

## Examples

### Nested printing

```julia
using ColorPrinting

cs = ColorScheme(:foo => :red, :bar => :green)
cs2 = ColorScheme(:foo => :red, :bar => :yellow)
print(cs, c"hello :foo{new :bar{green} world}!")
print(cs2, c"hello :foo{new :bar{green} world}!")
```

### Interpolation

```julia
using ColorPrinting
using Statistics

v = rand(100);
cs = ColorScheme(:median => :red, :δ => :yellow)

s = c"""
Median: :median{$(median(v))}
Standard deviation: :δ{$(std(v))}
"""

print(cs, s)
```
