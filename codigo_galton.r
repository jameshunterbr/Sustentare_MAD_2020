## Código para Cãlculos dos Dados de Galton
## Prof. James Hunter
## from: https://rstudio.cloud/project/1181172
## 28 de maio de 2020

library(tidyverse)

galton <- readRDS(here::here("galton.rds"))
str(galton)

boys <- galton %>% 
  filter(sex == "M") %>% 
  select(-family, -mother, -sex, -nkids)
glimpse(boys)

grpf <- ggplot(data = boys, aes(x = father, y = height)) + geom_point(shape = 20) + geom_rug()
grpf <- grpf + labs(x = "Altura do Pai", y = "Altura do Filho", title = "Alturas em Polegadas")
grpf

grpf2 <- grpf + geom_smooth(method = "lm", se = FALSE, color = "red")
grpf2

summarytools::descr(boys)
paste("Coeficiente de Correlação:", 
      with(boys, round(cor(father, height), 3)))

set.seed(1946)
boyscoef <-  coef(lm(height~father, data  = boys))
int <- boyscoef[1]; inc <- boyscoef[2] 
x <- boys %>% 
  filter((height >= 66 & height < 71) & (father >= 67 & father < 71)) %>% 
  sample_n(5) %>% 
  mutate(ypred = int + inc * father)
xplot <- ggplot(data = x, aes(x = father, y = height)) 
xplot <- xplot + geom_point(shape = 19, colour = "darkgreen")
xplot <- xplot + geom_abline(aes(intercept = int, slope = inc), colour = "darkred")
xplot <- xplot + geom_segment(aes(x = father[3], y = height[3], xend = father[3], 
                                  yend = ypred[3]), colour = "blue", 
                              arrow = arrow(length = unit(0.3,"cm")))
xplot <- xplot + geom_point(aes(x = father[3], y = ypred[3]), 
                            shape = 19, color = "blue" )
xplot <- xplot + annotate(geom = "text", x = 68.2, y = 68.7, 
                          label = "y-hat")
xplot <- xplot + annotate(geom = "text", x = 68.2, y = 66.8, label = "y(i)")
xplot

xplot2 <- xplot + geom_hline(yintercept = mean(boys$height), color = "orange")
xplot2 <- xplot2 + geom_segment(aes(x = father[3], y = ypred[3], 
                                    xend = father[3], 
                                    yend = mean(boys$height)), 
                                colour = "green", 
                                arrow = arrow(length = unit(0.3,"cm")))
xplot2 <- xplot2 + annotate(geom = "text", x = 67.7, y = 68.9, 
                            label = "SSR", color = "darkgreen")
xplot2 <- xplot2 + annotate(geom = "text", x = 67.5, y = 69.3, label = "y-bar")
xplot2 <- xplot2 + annotate(geom = "text", x = 67.7, y = 68, 
                            label = "SSE", color = "darkblue")
xplot2 <- xplot2 + geom_segment(aes(x = father[3] + 0.05, y = height[3], 
                                    xend = father[3] + .05, 
                                    yend = mean(boys$height)), 
                                colour = "red", 
                                arrow = arrow(length = unit(0.3,"cm")))
xplot2 <- xplot2 + annotate(geom = "text", x = 68.3, y = 68, 
                            label = "SST", color = "darkred")
xplot2

fit1 <- lm(height ~ father, data = boys)
summary(fit1)

broom::tidy(fit1) %>% knitr::kable()

coef(fit1) 

fit1 %>% broom::augment(newdata = data_frame(father = 72))