library(ggplot2)
link_to_img <- function(x, width = 30) {
  glue::glue("<img src='{x}' width='{width}'/>")
}

entrant_number <- 9680
all_gameweeks <- c(1:15)

my_picks <- lapply(all_gameweeks, function(gameweek) {
  gw_picks <- fplscrapR::get_entry_picks(entrant_number, gameweek)$picks
  gw_picks$gameweek <- gameweek
  return(gw_picks)
})

my_picks <- dplyr::bind_rows(my_picks)

# Obtaining all the player information to get their expected points
df <- fplscrapR::get_player_info() |>
  dplyr::select(
    .data$id, .data$team_code,
    .data$photo, .data$playername
  ) |>
  dplyr::mutate("element" = .data$id)

# Extract the player information for each entrant, to then create a
# ranked table
entrant_picks <- dplyr::left_join(my_picks, df) |>
  dplyr::select(
    .data$position, .data$is_captain,
    .data$is_vice_captain, .data$position,
    .data$team_code, .data$photo,
    .data$playername, .data$gameweek
  )

# Adding urls for team logo and player image
team_logo_url <- "https://resources.premierleague.com/premierleague/badges/70/"
player_picture_url <- "https://resources.premierleague.com/premierleague/photos/players/110x140/"

entrant_picks$team_code <- paste0(team_logo_url, "t", entrant_picks$team_code, ".png")

entrant_picks$photo <- paste0(player_picture_url, "p", entrant_picks$photo)
entrant_picks$photo <- gsub("jpg", "png", entrant_picks$photo)

owned_count <- entrant_picks |>
  dplyr::group_by(playername) |>
  dplyr::count()

entrant_picks <- dplyr::left_join(entrant_picks, owned_count)

# geomt tile with when players were owned
ggplot2::ggplot(entrant_picks, ggplot2::aes(x = gameweek, y = reorder(link_to_img(photo), n))) +
  viridis::scale_color_viridis(discrete = TRUE) +
  ggplot2::geom_tile() +
  ggplot2::scale_x_continuous(
    position = "top",
    breaks = entrant_picks$gameweek |>
      unique() |>
      sort()
  ) +
  pl_style() +
  ggplot2::theme(
    axis.text.y = ggtext::element_markdown(margin = margin(t = -25, unit = "pt")),
    legend.position = "none",
    panel.grid.major.y = ggplot2::element_blank(),
    axis.text = ggplot2::element_blank()
  ) +
  ggplot2::labs(
    x = NULL,
    title = "Players owned by gameweek for Team Name",
    subtitle = paste("You have owned", nrow(owned_count), "different players!"),
    caption = "\nSource: \nfplscrapR"
  )

# vis of starting lineups
ggplot2::ggplot(entrant_picks, ggplot2::aes(x = gameweek, y = reorder(position, -position))) +
  # viridis::scale_color_viridis(discrete = TRUE) +
  ggplot2::geom_point() +
  ggimage::geom_image(aes(image = photo)) +
  ggplot2::geom_hline(aes(yintercept = 4.5, colour = "red"))+
  ggplot2::scale_x_continuous(
    position = "top",
    breaks = entrant_picks$gameweek |>
      unique() |>
      sort()
  ) +
  pl_style() +
  ggplot2::theme(
    legend.position = "none",
    panel.grid.major.y = ggplot2::element_blank(),
    axis.text = ggplot2::element_blank()
  ) +
  ggplot2::labs(
    x = NULL,
    title = "Starting lineup",
    caption = "\nSource: \nfplscrapR"
  )
s
