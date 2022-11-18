entrant_picks <- get_players_owned(9680, c(1:16))

# geomt tile with when players were owned
ggplot2::ggplot(entrant_picks, ggplot2::aes(x = gameweek, y = reorder(link_to_img(photo), n_gameweeks_owned))) +
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
    subtitle = paste("You have owned", length(unique(entrant_picks$playername)), "different players!"),
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
