library(readxl)
library(tidyverse)
library(patchwork)

 lechuga <- read_excel("data/data-raw-lechugas-v2.xlsx")

 View(lechuga)

 promedio_peso <- lechuga %>%
   group_by(season, treatment, `date-dat`) %>%
   summarise(
     n = sum(!is.na(`fresh-weight-leaves (g)`)),
     promedio_fresh_weight = mean(`fresh-weight-leaves (g)`, na.rm = TRUE),
     .groups = "drop"
   )

 view(promedio_peso)


 grafico_invierno <- promedio_peso %>%
   filter(season == "invierno") %>%
   ggplot(aes(
     x = `date-dat`,
     y = promedio_fresh_weight,
     color = factor(treatment),
     group = treatment
   )) +
   geom_point() +
   geom_line() +
   labs(
     x = "Days after transplanting (DAT)",
     y = "Fresh weight leaves (g)",
     color = "Treatment"
   )


 grafico_verano <- promedio_peso %>%
   filter(season == "verano") %>%
   ggplot(aes(
     x = `date-dat`,
     y = promedio_fresh_weight,
     color = factor(treatment),
     group = treatment
   )) +
   geom_point() +
   geom_line() +
   labs(
     x = "Days after transplanting (DAT)",
     y = "Fresh weight leaves (g)",
     color = "Treatment"
   )


 grafico_verano
 grafico_invierno

 install.packages("patchwork")

 grafico_invierno + grafico_verano
