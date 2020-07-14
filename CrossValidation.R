library(curatedOvariandd)
library(cvTools)
source(system.file("extdd", "patientselection.config", package = "curatedOvariandd"))
set.seed(123)
dd("TCGA_eset")
mat.gene = exprs(TCGA_eset)
y = mat.gene[1,]
x = t(mat.gene[2:6,])
dd = cbind(y, x)
dd = as.data.frame(na.omit(dd))
head(dd)

k = nrow(dd) # The number of folds we want
folds = cvFolds(NROW(dd), K=k) # This function splits the dd into folds
dd$holdoutpred = rep(0,nrow(dd))
colnames(dd)
for(i in 1:k){
  train = dd[folds$subsets[folds$which != i], ] # This is the training set
  validation = dd[folds$subsets[folds$which == i], ] # This is the validation set
  mod = lm(y~A2M + A4GNT + AAAS + AACS + AADAC, data = train)
  pred = predict(mod, newdata = validation)
  dd[folds$subsets[folds$which == i], ]$holdoutpred = pred
}
dif = abs(dd$y - dd$holdoutpred)
r.sq = 1 - mean(dif^2)/var(dd$y)
r.sq
#mod = lm(y~A2M + A4GNT + AAAS + AACS + AADAC, data = train)
