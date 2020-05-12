## Exercicio 3
## Prof. James Hunter
## from: https://rstudio.cloud/project/1177204
## 11 de maio de 2020

# Acertar que os pacotes estão instalados
install.packages("Hmisc", "summarytools")

library(tidyverse, Hmisc, summarytools)

# Estrutura

str(mob_sp)
glimpse(mob_sp)

# Resumos

summary(mob_sp)
summarytools::dfSummary(mob_sp)
summarytools::descr(mob_sp)
Hmisc::describe(mob_sp)
