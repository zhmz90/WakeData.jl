
function totalGeneCDSLength(cosmicpath)
    kv = Dict{ASCIIString,Int64}()
    open(cosmicpath) do file
        header = readline(file)
        while !eof(file)
            line = readDiscreteLine(file)
            gene_name = line[1]
            gene_cds_length = line[3]
            if !in(gene_name, keys(kv))
                kv[gene_name] = parse(Int64, gene_cds_length)
            end            
        end        
    end
    sum(keys(kv)),sum(values(kv))
end
