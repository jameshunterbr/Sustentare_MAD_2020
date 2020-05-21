## Exercício 9
## Prof. James Hunter
## from: https://rstudio.cloud/project/1181172
## 28 de maio de 2020
##
## Simulação das Camisetas de Sustentare -- Uma Vez
## Todos os dados totalmente inventados
## Similaridade entre esta versão da Sustentare e a verdadeiro é 100% por acaso


# Carregar pacotes

library(tidyverse)

# Premissas/Dados

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

# Modelo

# colocar as variáveis num tibble

camis <- tibble(desenv = numeric(length = anos), # variáveis numericas
                publico =  numeric(length = anos),
                custo = numeric(length = anos),
                preco = numeric(length = anos),
                compras = numeric(length = anos),
                renda = numeric(length = anos),
                lucro = numeric(length = anos)) 


# Carregar camis com os valores

## não precisa loop para desenv - só ocorre em ano 1

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

# set.seed() para tudo mundo tem o mesmo resultado

set.seed(42)

prop_compras <- runif(5, min = min_prop, max = max_prop)

camis <- camis %>% 
  mutate(compras = publico * prop_compras,
         renda = compras * preco,
         lucro = renda - desenv - custo * compras)

# Calcular os Totais

total_camis <- camis %>% 
  summarise(media_prop = mean(prop_compras),
            tot_compras = sum(compras),
            tot_renda = sum(renda),
            tot_lucro = sum(lucro))

total_camis





