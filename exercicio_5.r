## Exercício 5
## Prof. James Hunter
## from: https://rstudio.cloud/project/1181159
## 12 de maio de 2020

# Passo 1: Carregar Pacotes Necessários
library(tidyverse)
library(summarytools)

# Passo 2: Colocar starwars na memoria como "sw" utilizando so 
#          variáveis name até species; 2 alternativas
sw <- starwars[, 1:10] # base R--todas as fileiras, colunas 1:10
sw <- starwars %>%             # tidyverse
  select(name:species)

# Passo 3: Olhar na estrutura dos dados
str(sw)

# Passo 4: Olhar em todas as variáveis

summarytools::dfSummary(sw, graph.col = FALSE)



