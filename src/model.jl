@doc """ xgboost for train,val,test dataset without gridtune
""" ->
function model_xgboost(train, val, test, num_iter::Int64)
    train_X,train_Y = train[:,1:end-1],train[:,end]
    val_X,val_Y = val[:,1:end-1],val[:,end]
    test_X,test_Y = test[:,1:end-1],test[:,end]
    
    num_class = maximum(train_Y)+1
    m_tr,n_tr   = size(train_X)
    m_val,n_val = size(val_X)    
    info("in the model, there are $num_class classes")
    info("train_X size is :$m_tr,$n_tr")
    info("val_X size is : $m_val, $n_tr")

    num_round = num_iter
    
    dtrain = DMatrix(train_X, label = train_Y)
    dval   = DMatrix(val_X,   label = val_Y)
    dtest  = DMatrix(test_X,  label = test_Y)   
    
    watch_list = [(dtrain,"train"), (dval,"val")]
    param      = Dict{ASCIIString,Any}("max_depth"=>7,"eta"=>0.01,"nthread"=>50,
                                       "objective"=>"multi:softprob","silent"=>1,
                                       #"alpha"=>0.7,
                                       "sub_sample"=>0.9)#  ,"num_class"=>num_class)
   
    bst = xgboost(dtrain,num_round,watchlist=watch_list,param=param,num_class=num_class,
                  metrics=["mlogloss", "merror"],seed=2015)
    
    test_preds = XGBoost.predict(bst, test_X)
    
    yprob = reshape(test_preds, Int64(num_class), size(test_X,1))
    ind_prob = map(ind->indmax(yprob[:,ind]), 1:size(test_X,1))
    test_preds = ind_prob - 1 
    
    return bst
end
