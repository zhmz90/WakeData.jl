module ensp

function ensemble()
    csvs = map(x->joinpath("data",x), readdir("data"))
    
    ids = Array{ASCIIString,1}[]
    for csv in csvs
        data = readcsv(csv,ASCIIString)
        id = data[2:end,1]
        push!(ids,id)
        info(csv)
    end 
    
    #=
    for i in 1:length(ids)-1
        @assert ids[i] == ids[i+1]
        info("check ids $i")
    end 
    =#

    targets = Array{Float64,1}[]
    for csv in csvs
        data = readcsv(csv,ASCIIString)
        target = map(x->parse(Float64,x), data[2:end,2])
        push!(targets, target)
    end 
    
    header = Any["id", "pred"]

    @show size(targets)
    #target = targets .* 
    target = zeros(targets[1])
    weights = [0.2 for i=1:5]
    for i in 1:5
        target += targets[i] * weights[i]
    end 

    data = vcat(header', hcat(ids[1],target))
    @show data[1:3,:]
    name = "ensemble_5.csv"
    writecsv(name, data)
    run(`gzip -9 $name`)
    info("done")    
end



end
