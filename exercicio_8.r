## Exercício 8
## Prof. James Hunter
## from: https://rstudio.cloud/project/1181159
## 12 de maio de 2020

# colocar mpg em memoria

mpg <- mpg

# Objetivo: displ x cty com drv

ggplot(data = mpg, mapping = aes(x = displ, y = cty, colour = drv)) +
  geom_point() 
