## Exercicio 4
## Prof. James Hunter
## from: https://rstudio.cloud/project/1177204
## 11 de maio de 2020

# library(tidyverse)
# library(summarytools)

mob_sp %>% 
  filter(mode == "transit") %>% 
  summarytools::descr()
