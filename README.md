# WakeData.jl

Linux OSX: [![Build Status](https://travis-ci.org/zhmz90/WakeData.jl.svg?branch=master)](https://travis-ci.org/zhmz90/WakeData.jl)

This package aims to collect useful functions for analysis big data.

### Installation

    Pkg.clone("https://github.com/zhmz90/WakeData.jl.git")
	
### Functions 

```Julia
# reformat dataset
reformat(data)  # 2 columns
reformat3(data) # 3 columns

#left join datasets with the first columns as id
leftjoindata(dt1,dt2) 
leftjoindata(dt1,dt2,dt3...)

#split dataset to train,validation,test
splitdata(data)

#shuffle dataset 
shuffle(data)

```

	
