## Exercicio 2
## Prof. James Hunter
## from: https://rstudio.cloud/project/1177204
## Dados de Apple Computer, https://www.apple.com/covid19/mobility
## 11 de maio de 2020

library(tidyverse)
mob_sp <- read_csv(here::here("sp_mobilidade_apple_240420b.csv"), col_names = TRUE)
str(mob_sp) # Mostrar a estrutura do conjunto de dados
