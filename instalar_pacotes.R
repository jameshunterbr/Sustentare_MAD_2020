## Programa para automatizar o download dos pacotes
## necessários para o curso de Análise dos Dados com R
## Author: James R. Hunter, Ph.D.
## Date: 21/04/2020
## Versão: 5.0

pacotes <- c("tidyverse", "broom", "car", "caret", "corrr", "data.table", 
             "descr", "devtools", "gapminder", "ggpubr", "ggvis", "glue",
             "gmodels", "here", "Hmisc", "hms", "janitor", "jsonlite", 
             "kableExtra", "knitr", "lattice", "librarian", "lubridate", 
             "magrittr", "mice", "nortest", "nycflights13", "outliers", 
             "pROC", "psych", "RColorBrewer", "Rcpp", "readxl", "ROCR", 
             "shiny", "styler", "usethis", "titanic")

install.packages(pacotes)