library(MASS)
library(verification)
library(curatedOvarianData)
source(system.file("extdata", "patientselection.config", package = "curatedOvarianData"))
set.seed(123)
data("TCGA_eset")
y = TCGA_eset$recurrence_status
y = ifelse(y == "recurrence", 1, 0)
mat.gene = exprs(TCGA_eset)
x = cbind(TCGA_eset$age_at_initial_pathologic_diagnosis,
          TCGA_eset$percent_normal_cells,TCGA_eset$percent_tumor_cells, TCGA_eset$grade)
subset.gene = t(mat.gene[1 : 200, ])
x.new = cbind(x,subset.gene )
rr = data.frame(na.omit(cbind(y,x.new)))
model = glm(y~., data = rr, family=binomial(link='logit'))
pred1 = predict(model, type='response', probability =TRUE)
library(pROC)
library(e1071)
#roc.model = multiclasss.roc(y, pred1)
m.roc = multiclass.roc(rr$y, pred1)
m.roc$auc
#roc.model$auc
