# ORIGINAL SOURCE: https://raw.githubusercontent.com/ja-thomas/OMLbots/master/R/botSetLearnerParamPairs.R
# xgboost was corrected here:

#' getSimpleLearners
#' 
#' Define some simple learners with parameter sets to be explored by the bot
#' @return a learner parameter set
#' @export
getSimpleLearners = function(){
  # Simple learner param set
  simple.lrn.par.set = makeLrnPsSets(learner = makeLearner("classif.glmnet", predict.type = "prob"),
    param.set = makeParamSet(
      makeNumericParam("alpha", lower = 0, upper = 1, default = 1),
      makeNumericVectorParam("lambda", len = 1L, lower = -10, upper = 10, default = 0 ,trafo = function(x) 2^x)))
  
  simple.lrn.par.set = makeLrnPsSets(learner = makeLearner("classif.rpart", predict.type = "prob"), 
    param.set = makeParamSet(
      makeNumericParam("cp", lower = 0, upper = 1, default = 0.01),
      makeIntegerParam("maxdepth", lower = 1, upper = 30, default = 30),
      makeIntegerParam("minbucket", lower = 1, upper = 60, default = 1),
      makeIntegerParam("minsplit", lower = 1, upper = 60, default = 20)), 
    lrn.ps.sets = simple.lrn.par.set)
  
  return(simple.lrn.par.set)
}

#' getMultipleLearners
#' 
#' Expand the simple learner set by more learners.
#' @return a learner parameter set
#' @export
getMultipleLearners = function(){
  simple.lrn.par.set = getSimpleLearners()
  
  # increase to a general param set
  lrn.par.set = makeLrnPsSets(learner = makeLearner("classif.kknn", predict.type = "prob"), 
    param.set = makeParamSet(
      makeIntegerParam("k", lower = 1, upper = 30)),
    lrn.ps.sets = simple.lrn.par.set)
  
  lrn.par.set = makeLrnPsSets(learner = makeLearner("classif.svm", predict.type = "prob"), 
    param.set = makeParamSet(
      makeDiscreteParam("kernel", values = c("linear", "polynomial", "radial")),
      makeNumericParam("cost", lower = -10, upper = 10, trafo = function(x) 2^x),
      makeNumericParam("gamma", lower = -10, upper = 10, trafo = function(x) 2^x, requires = quote(kernel == "radial")),
      makeIntegerParam("degree", lower = 2, upper = 5, requires = quote(kernel == "polynomial"))),
    lrn.ps.sets = lrn.par.set)
  
  lrn.par.set = makeLrnPsSets(learner = makeLearner("classif.ranger", predict.type = "prob"), 
    param.set = makeParamSet(
      makeIntegerParam("num.trees", lower = 1, upper = 2000),
      makeLogicalParam("replace"),
      makeNumericParam("sample.fraction", lower = 0.1, upper = 1),
      makeNumericParam("mtry", lower = 0, upper = 1),
      makeLogicalParam(id = "respect.unordered.factors"),
      makeNumericParam("min.node.size", lower = 0, upper = 1)),
    lrn.ps.sets = lrn.par.set)
  
  lrn.par.set = makeLrnPsSets(learner = makeLearner("classif.xgboost", predict.type = "prob"), 
    param.set = makeParamSet(
      makeIntegerParam("nrounds", lower = 1, upper = 5000), 
      makeDiscreteParam("booster", values = c("gbtree", "gblinear")),
      makeNumericParam("eta", lower = -10, upper = 0, requires = quote(booster == "gbtree"), trafo = function(x) 2^x),
      makeNumericParam("subsample",lower = 0.1, upper = 1, requires = quote(booster == "gbtree")),
      makeIntegerParam("max_depth", lower = 1, upper = 15, requires = quote(booster == "gbtree")),
      makeNumericParam("min_child_weight", lower = 0, upper = 7, requires = quote(booster == "gbtree"), trafo = function(x) 2^x),
      makeNumericParam("colsample_bytree", lower = 0, upper = 1, requires = quote(booster == "gbtree")),
      makeNumericParam("colsample_bylevel", lower = 0, upper = 1, requires = quote(booster == "gbtree")),
      makeNumericParam("lambda", lower = -10, upper = 10, requires = quote(booster == "gblinear"), trafo = function(x) 2^x),
      makeNumericParam("alpha", lower = -10, upper = 10, requires = quote(booster == "gblinear"), trafo = function(x) 2^x)),
    lrn.ps.sets = lrn.par.set)
  
  return(lrn.par.set)
}


