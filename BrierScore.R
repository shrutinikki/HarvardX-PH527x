library(MASS)
library(verification)
library(curatedOvarianData)
source(system.file("extdata", "patientselection.config", package = "curatedOvarianData"))
set.seed(123)
data("TCGA_eset")
y = TCGA_eset$recurrence_status
y = ifelse(y == "recurrence", 1, 0)
x = cbind(TCGA_eset$age_at_initial_pathologic_diagnosis,
          TCGA_eset$percent_normal_cells,TCGA_eset$percent_tumor_cells, TCGA_eset$grade)
bb = data.frame(na.omit(cbind(y,x)))
head(bb)
l = glm(y~., data = bb, family=binomial(link='logit'))
summary(l)

pred1 = predict(l, type='response')
brier1=mean((pred1 - y)^2)

verify(y, pred1)$bs