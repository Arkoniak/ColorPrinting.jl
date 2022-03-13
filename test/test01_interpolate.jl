module InterpolateTest

using ColorPrinting
using ReTest

using ColorPrinting: interpolate, @interpolate

@testset "basic" begin
    x = 1
    @test eval(interpolate("foo")) == "foo"
    @test eval(interpolate("foo$x")) == "foo1"
    @test eval(interpolate("foo$(x + 1)")) == "foo2"
    @test eval(interpolate("foo$(x + 1)bar")) == "foo2bar"
    @test eval(interpolate("foo$(x)bar$x")) == "foo1bar1"
    @test eval(interpolate("foo$(x + (x - 3))")) == "foo-1"
end


z(s) = s*s
macro bar_str(s)
    quote
        x = @interpolate $s
        z(x)
    end
end

@testset "macro interpolate" begin
    x = 3
    let y = 1
        @test bar"a$y" == "a1a1"
        @test bar"a$(x + y)b" == "a4ba4b"
    end
end

end # module
