export reformat,reformat3

function reformat(data::Array{ASCIIString,2})
    data = data[2:end,:]
    id_event = Dict{ASCIIString,Set{ASCIIString}}()
    for i in 1:size(data,1)
        id = data[i,1]
        if in(id,keys(id_event))
            push!(id_event[id],data[i,2])
        else
            id_event[id] = Set{ASCIIString}([data[i,2]])
        end
    end

    colname = sort(unique(data[:,2]))
    lencol  = length(colname)
    shape   = length(unique(data[:,1])),length(colname)+1
    result  = Array{ASCIIString,2}(shape)
    for (ind,id) in enumerate(keys(id_event))
        vec = Array{ASCIIString,1}(lencol)
        events = id_event[id]
        for (idx,col) in enumerate(colname)
            if in(col,events)
                vec[idx] = "1"
            else
                vec[idx] = "0"
            end
        end
        result[ind,:] = deepcopy(vcat(id,vec))
    end

    #index array with id
    ret_dict = Dict{ASCIIString,Array{ASCIIString,1}}()
    for i = 1:size(result,1)
        ret_dict[result[i,1]] = result[i,2:end]
    end
    
    result,ret_dict
end

function reformat3(data::Array{ASCIIString,2})
    data = data[2:end,:]
    #make rowname=>colname index
    id_event = Dict{ASCIIString,Set{Tuple{ASCIIString,ASCIIString}}}()
    for i in 1:size(data,1)
        id = data[i,1]
        if in(id,keys(id_event))
            push!(id_event[id],(data[i,2],data[i,3]))
        else
            id_event[id] = Set{Tuple{ASCIIString,ASCIIString}}([(data[i,2],data[i,3])])
        end
    end
 
    colname = sort(unique(data[:,2]))
    lencol  = length(colname)
    shape   = length(unique(data[:,1])),length(colname)+1
    result  = Array{ASCIIString,2}(shape)
    for (ind,id) in enumerate(keys(id_event))
        vec = Array{ASCIIString,1}(lencol)
        events = map(x->x[1], collect(id_event[id]))
        for (idx,col) in enumerate(colname)
            if in(col,events)
                vec[idx] = collect(id_event[id])[col .== events][1][2]
            else
                vec[idx] = "0"
            end
        end
        result[ind,:] = deepcopy(vcat(id,vec))
    end

    #index array with id
    ret_dict = Dict{ASCIIString,Array{ASCIIString,1}}()
    for i = 1:size(result,1)
        ret_dict[result[i,1]] = result[i,2:end]
    end
    
    result,ret_dict
end


@doc """ the last column as lable column, ratio is 6:2:2
assume data doest not contain header part
""" ->
function splitdata{T<:Any}(dt::Array{T,2})
    labels = Set(dt[:,end])
    num_row,num_col = size(dt)
    tr,val,te = Array{T,2}(0,num_col),Array{T,2}(0,num_col),Array{T,2}(0,num_col)

    for lb in labels
        inds = dt[:,end] .== lb
        data = dt[inds,:]
        len = size(data,1)
        trval = Int64(round(len*0.6))
        valte = trval + Int64(round(len*0.2))
        tr  = vcat(tr, data[1:trval,:])
        val = vcat(val,data[trval+1:valte,:])
        te  = vcat(te, data[valte+1:end,:])
    end

    tr,val,te
end

@doc """ shuffle dataset
random indexes of row
""" ->
function shuffle(data)
    m,n = size(data)
    inds = randperm(m)
    data[inds,:]
end
