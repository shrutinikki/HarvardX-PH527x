source("https://bioconductor.org/biocLite.R")
biocLite("curatedOvarianData")
library("curatedOvarianData")
source(system.file("extdata", "patientselection.config", package = "curatedOvarianData"))
data("GSE17260_eset")
set.seed(123)
mat.gene = exprs(GSE17260_eset)

#Rsquare
y=mat.gene[1,] 
x=mat.gene[2:11,]
dd = cbind(y, x)
dd = as.data.frame(na.omit(dd))
head(dd)
tail(dd)
colnames(dd[2:11])
summary(lm(y~GSM432220+GSM432221+GSM432222+GSM432223+GSM432224+GSM432225+GSM432226+GSM432227+GSM432228+GSM432229, data = dd))

#brierscore
library(MASS)
library(verification)

y = GSE17260_eset$vital_status
y = ifelse(y == "deceased", 1, 0)
x = cbind(as.numeric(GSE17260_eset$tumorstage), GSE17260_eset$grade)
bb = data.frame(na.omit(cbind(y,x)))
l = glm(y~., data = bb, family=binomial(link='logit'))
summary(l)

pred1 = predict(l, type='response')
brier1=mean((pred1 - y)^2)

verify(y, pred1)$bs


#AUC
mat.gene = exprs(GSE17260_eset)
subset.gene = t(mat.gene[1:50, ])
y = GSE17260_eset$vital_status
y = ifelse(y == "deceased", 1, 0)
uu = data.frame(na.omit(cbind(y, subset.gene)))
model = glm(y~., data = uu, family=binomial(link='logit'))
pred1 = predict(model, type='response', probability =TRUE)
library(pROC)
library(e1071)
#roc.model = multiclasss.roc(y, pred1)
m.roc = multiclass.roc(uu$y, pred1)
m.roc$auc


#bootstraping

y = GSE17260_eset$vital status
y = ifelse(y == "deceased", 1, 0)
x = cbind(as.numeric(GSE17260_eset$tumorstage), GSE17260_eset$grade)
bb = data.frame(na.omit(cbind(y,x)))

B = 1000 # Number of iterations
brier.boot <- rep(NA, B) # Allocation vector
for(b in 1:B){
  
  # Resample
  idx = sample(1:nrow(bb), nrow(bb), replace=T)
  # Bootstrap sample
  x.bot = bb[idx,]
  
  # Fit the model
  mod.low = glm(y ~ ., data = x.bot, family=binomial(link=logit))
  pred = predict(mod.low, type='response')
  tt = verify(x.bot[,1], pred)
  
  # Evaluate the estimator
  brier.boot[b] = tt$bs
}
sd(brier.boot)
