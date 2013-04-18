using VectorUtils

function test_chained_vector()
    v1 = [1, 2, 3]
    v2 = [4, 5, 6]
    cv = ChainedVector{Int}(v1, v2)
    for i in 1:6
        @assert i == cv[i]
    end
end

function test_sub_vector()
    v1 = [1, 2, 3, 4, 5, 6]
    sv = SubVector{Int}(v1, 2:5)
    for i in 2:5
        @assert i == sv[i-1]
    end
end

function time_vect()
    v = zeros(Int, 1024*1024*64)
    vect_time = @elapsed begin
        x = 0
        i = 1
        while(i < length(v))
            x += v[i]
            i+=1
        end
        println(x)
    end
    println("Vector: $vect_time")
end

function time_cv()
    cv = ChainedVector{Int}(zeros(Int, 1024*1024*32), zeros(Int, 1024*1024*32))
    cv_time = @elapsed begin
        i = 1
        x = 0
        l = length(cv)
        while(i < l)
            x += cv[i]
            i+=1
        end
        println(x)
    end

    println("ChainedVector: $cv_time")
end

function time_subarr()
    v = zeros(Int, 1024*1024*64)
    sa = sub(v, 2:length(v)-1)
    sa_time = @elapsed begin
        i = 1
        x = 0
        l = length(sa)
        while(i < l)
            x += sa[i]
            i += 1
        end
        println(x)
    end
    println("SubArray: $sa_time")
end

function time_subvect()
    v = zeros(Int, 1024*1024*64)
    sa = SubVector{Int}(v, 2:length(v)-1)
    sv_time = @elapsed begin
        i = 1
        x = 0
        l = length(sa)
        while(i < l)
            x += sa[i]
            i += 1
        end
        println(x)
    end
    println("SubVector: $sv_time")
end

test_chained_vector()
test_sub_vector()
time_vect()
time_cv()
time_subvect()
time_subarr()


