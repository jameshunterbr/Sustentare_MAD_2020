## Exercício 10
## Prof. James Hunter
## from: https://rstudio.cloud/project/1181172
## 28 de maio de 2020
##
## Simulação das Camisetas de Sustentare -- Uma Vez
## Todos os dados totalmente inventados
## Similaridade entre esta versão da Sustentare e a verdadeiro é 100% por acaso


library(tidyverse)
library(summarytools)

## Variáveis Básicas (repetido da ex. 9)

publico_ano1 <- 4000 #número total dos alunos/ex-alunos
novo_publico <- 250 #número novo de alunos por ano
custo_ano1 <- 32 #custo da camiseta estampada com logo e nome em reais
inflacao <- .05 #aumento de custos anual (inflação)com
markup <- 1 #fator para adicionar ao custo para determinar preço de venda
#ex. 1 = 100%
desenv_ano1 <- 20000 # cobrança em ano 1 para desenvolver produto, mktg, etc.
anos <- 5L #número de anos para julgar se programa vale a pena
min_prop <- 0.15 # min e max proporções do público que vai comprar
max_prop <- 0.40

# Número de Iterações

n_sims <- 1000


# Repositório dos Resultados
# Guardar vazio

total_camis <- tibble(sim = integer(n_sims),
                      media_prop = double(n_sims),
                      tot_compras = double(n_sims),
                      tot_renda = double(n_sims),
                      tot_lucro = double(n_sims))



# Funcao do Modelo - Simulação Individual

camis_modelo <- function() {
  # colocar as variáveis num tibble
  
  camis <- tibble(desenv = numeric(length = anos), 
                  publico =  numeric(length = anos),
                  custo = numeric(length = anos),
                  preco = numeric(length = anos),
                  compras = numeric(length = anos),
                  renda = numeric(length = anos),
                  lucro = numeric(length = anos)) 
  
  
  # Carregar camis com os valores
  
   camis$desenv[1] <- desenv_ano1
  
  ## Outras precisam loop
  
  for (i in 1:anos) {
    camis$publico[i] <- publico_ano1 + (i - 1) * novo_publico
    camis$custo[i] <- custo_ano1 * (1 + inflacao)^(i-1)
    camis$preco[i] <- camis$custo[i] * (1 + markup)
  }
  
  # variável probabilística -- qual proporção do público vai comprar
  # aleatórico entre 15% e 40%
  # usar distribuição uniforme -- runif()
  # premissa: que pode comprar mais de uma vez
  
  prop_compras <- runif(5, min = min_prop, max = max_prop)
  
  camis <- camis %>% 
    mutate(compras = publico * prop_compras,
           renda = compras * preco,
           lucro = renda - desenv - custo * compras)
  
  # Calcular os Totais
  
  sum_camis <- camis %>% 
    summarise(media_prop = mean(prop_compras),
              tot_compras = sum(compras),
              tot_renda = sum(renda),
              tot_lucro = sum(lucro))
  
  # Salvar os resultados
  
  return(sum_camis)
}

## Executar a Simulação

# set.seed() para tudo mundo tem o mesmo resultado

set.seed(42)

# iniciar sum_camis para receber dados da função

sum_camis <- tibble(sim = integer(n_sims),
                    media_prop = double(n_sims),
                    tot_compras = double(n_sims),
                    tot_renda = double(n_sims),
                    tot_lucro = double(n_sims))

# Loop

inicio_loop = Sys.time()

for (n in 1:n_sims){
  sum_camis <- camis_modelo() 
  
  # Carregar resultados
  
  total_camis$sim[n] = n
  total_camis$media_prop[n] = sum_camis$media_prop
  total_camis$tot_compras[n] = sum_camis$tot_compras
  total_camis$tot_renda[n] = sum_camis$tot_renda
  total_camis$tot_lucro[n] = sum_camis$tot_lucro
}

termino_loop = Sys.time()

print(glue::glue("Tempo de execução = ", round(termino_loop - inicio_loop, 2), " segundos"))

## Analisar Resultados

summarytools::descr(total_camis[, 2:5], stats = c("mean", "sd", "min", "med",
                                           "max", "iqr", "cv"))
