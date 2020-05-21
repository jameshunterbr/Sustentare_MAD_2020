## Demo de for Loops
## Prof. James Hunter
## from: https://rstudio.cloud/project/1181172
## 28 de maio de 2020
## Baseado em Cap. 21 de Grolemund & Wickham, R for Data Science (O'Reilly)

set.seed(42)

df <- tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

glimpse(df)


set.seed(42)
output <- numeric(length = ncol(df))

for(i in seq_along(output)) {
  output[i] <- median(df[[i]]) # dupla [[]] porque median veja df como lista
}

output
