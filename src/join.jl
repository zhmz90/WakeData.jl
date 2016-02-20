@doc """ index array data with the first column
""" ->
function index(dt)
    dict = Dict{ASCIIString,Array{ASCIIString,1}}()
    for i = 1:size(dt,1)
        dict[dt[i,1]] = dt[i,2:end]
    end
    dict
end

@doc """ left join data on the first column, assume have the same ids
And data have no header part
""" ->
function leftjoindata(d1,d2)
    d1_ind = index(d1)
    d2_ind = index(d2)
    @assert issubset(Set(collect(keys(d1_ind))),Set(collect(keys(d2_ind)))) == true
    nrow = size(d1,1)
    ncol = size(d1,2)-1 + size(d2,2)-1 + 1
    data = Array{ASCIIString,2}(nrow,ncol)
    for (i,id) in enumerate(keys(d1_ind))
        data[i,:] = vcat(id,d1_ind[id], d2_ind[id])'
    end
    data
end

function leftjoindata(d1,d2,d3...)
    #left join
    data = leftjoindata(d1,d2)
    for d in d3
        data = leftjoindata(data,d)
    end
    data
end
