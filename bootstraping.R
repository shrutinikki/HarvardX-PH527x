library(curatedOvarianData)
library(verification)
library(MASS)
source(system.file("extdata", "patientselection.config", package = "curatedOvarianData"))
set.seed(123)
data("TCGA_eset")
y = TCGA_eset$recurrence_status
y = ifelse(y=="recurrence",1,0)
x = cbind(TCGA_eset$age_at_initial_pathologic_diagnosis,
          TCGA_eset$percent_normal_cells,TCGA_eset$percent_tumor_cells,
          TCGA_eset$grade)
bb = data.frame(na.omit(cbind(y,x)))
head(bb)

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
quantile(mean(brier.boot), probs = 0.025)
quantile(sd(brier.boot), probs = 0.975)