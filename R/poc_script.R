library(fplscrapR)
library(dplyr)

benchwarmers <- get_league_entries(570437)

everyone_picks <- lapply(benchwarmers$entry, function(entry_name) {
  pick <- get_entry_picks(
    entry_name,
    gw = 4
  )$picks

  pick$entry <- entry_name

  pick
})

everyone_picks <- bind_rows(everyone_picks)

league_names <- benchwarmers %>%
  select(entry, player_name, entry_name)

league_picks <- left_join(league_names, everyone_picks)

df <- get_player_info() %>%
  select(id, playername, ep_next, value_form, selected_by_percent) %>%
  mutate("element" = id)

df$ep_next <- as.numeric(df$ep_next)

league_picks <- left_join(league_picks, df)
