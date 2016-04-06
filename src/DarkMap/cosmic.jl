
### stat functions

@doc """ return value type must be real
""" ->
function isGenomeWideScreen{T}(row::Array{T,1})
    # Genome-wide screen is in the 16th column
    gws = row[16]
    if gws == "y"
        return 1
    elseif gws == "n"
        return 0
    else
        error("GenomeWideScreen column is neither y or n")
    end
end

function getGeneCDSLength(row::Array{ASCIIString,1})
    # getGeneCDSLength is in the 3th column
    parse(Int64, row[3])
end



### typical read pipeline
function readDiscreteLine(file::IOStream)
    map(x->convert(ASCIIString,x), split(strip(readline(file)),'\t'))
end

function statCosmic(funcs::Array{Function,1}, filepath)
    i = 0
    function ProgressInfo(numCounter)
        i += 1
        if i % numCounter == 0
            info("In the line $i")
        end
    end
    
    stats = zeros(Int64, length(funcs))
    
    open(filepath) do file
        header = readDiscreteLine(file)
        while !eof(file)
            row = readDiscreteLine(file)
            stats = stats + map(f->f(row), funcs)            
            ProgressInfo(100_000)
        end
    end
    stats
end

function stat()
    statCosmic(Function[isGenomeWideScreen, getGeneCDSLength], "../data/CosmicCompleteExport.tsv")
end
