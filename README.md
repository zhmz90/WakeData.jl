# WakeData.jl

Linux OSX: [![Build Status](https://travis-ci.org/zhmz90/WakeData.jl.svg?branch=master)](https://travis-ci.org/zhmz90/WakeData.jl)

For us, data science is more than a skill or profession. It is a calling and a way of life. It rewards grit as much as talent. Failure, curiosity, and small successes lead to larger advances. Data science grants the power of discovery to the individual.

See if you have what it takes to observe the right patterns, ask the right questions and, in turn, make our beautiful and complex world a little easier to understand and a better place to live. 

### Installation

    Pkg.clone("https://github.com/zhmz90/WakeData.jl.git")
	
### Functions 

```Julia
#index data with its first column
index(data)

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

#get min mean median max of a vec
minmeanmedianmax(vec)
# get min mean median max for each column of data
statcols(data)

#model XGBoost
model_xgboost(tr,val,test,1000)

# model ensemble
ensp.ensemble()

```

	
