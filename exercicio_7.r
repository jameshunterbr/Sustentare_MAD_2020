## Exercício 7
## Prof. James Hunter
## from: https://rstudio.cloud/project/1181159
## 12 de maio de 2020

# Só precisa executar passos 1 e 2 se sw saiu de memoria

# Passo 1: Carregar Pacotes Necessários
library(tidyverse)
library(summarytools)

# Passo 2: Colocar starwars na memoria como "sw" utilizando so 
#          variáveis name até species; 2 alternativas
sw <- starwars[, 1:10] # base R--todas as fileiras, colunas 1:10
sw <- starwars %>%             # tidyverse
  select(name:species)

# Passo 3: Fazer o resumo para gêneros

sw %>% 
  group_by(gender) %>% # dividir dados em 4 grupos
  summarytools::descr(height)
