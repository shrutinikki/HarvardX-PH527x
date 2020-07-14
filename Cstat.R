library(MASS)
library(verification)
library(curatedOvarianData)
source(system.file("extdata", "patientselection.config", package = "curatedOvarianData"))
set.seed(123)
data("TCGA_eset")
y1 = TCGA_eset$days_to_death
y2 = TCGA_eset$vital_status
y2 = ifelse(y2 == "deceased",1,0)
V = as.numeric(TCGA_eset$tumorstage)
ttt = cbind(y1,y2,V)
ttt = as.data.frame(na.omit(ttt))
library(survival)
library(KMsurv)
library(survAUC)
library(dynpred)
bmt.train = ttt[1:277, ]
bmt.test = ttt[278:554, ]
mod.surv.train = coxph(Surv(y1,y2) ~ V, data = bmt.train)
lpnew = predict(mod.surv.train, new.data = bmt.test)
Surv.rsp = Surv(bmt.train$y1, bmt.train$y2) # The outcomes of the training data
Surv.rsp.new = Surv(bmt.test$y1, bmt.test$y2)
Cstat = UnoC(Surv.rsp, Surv.rsp.new, lpnew)
Cstat