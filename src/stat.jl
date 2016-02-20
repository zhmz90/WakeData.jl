
function minmeanmedianmax(vec)
    (minimum(vec),round(mean(vec),2),median(vec),maximum(vec))
end
function statcols(data)
    num_col = size(data,2)
    for ind in 1:num_col
        tmp = data[:,ind]
        print("min mean median max for $l class: ")
        println(minmeanmedianmax(tmp))
    end
end
