gr_di_c_int_facet <- interest %>%
  group_by(country) %>% 
  mutate(inc_c = confirmed - lag(confirmed)) %>%
  filter(date > "2020/02/22") %>%
  select(date, inc_c, country) %>% 
  ggline(x = "date",
         y = "inc_c",
         plot_type = "l",
         group = "country",
         color = "country",
         palette = "uchicago", 
         title = "Daily Increase in Cases -- Select Western Countries",
         xlab = FALSE,
         ylab = "Increase in Confirmed Cases (000s)",
         legend = "none",
         repel = TRUE,
         ggtheme = theme_gray())  +
  scale_x_date(date_breaks = "15 days", date_labels = "%m/%d") +
  scale_y_continuous(labels = number_format(scale = 0.001, big.mark = ",")) +
  facet_wrap("country", scales = "free_y")

gr_di_c_int_facet