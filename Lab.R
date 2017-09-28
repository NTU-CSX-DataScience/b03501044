glimpse(hflights)

avg_dest_delay = hflights %>%
    group_by(Dest) %>%
    summarise(delay = mean(ArrDelay,na.rm = TRUE)) %>%
    inner_join(airports,by = c("Dest" = "faa"))


avg_dest_delay %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point(aes(colour = delay)) +
  coord_quickmap()
