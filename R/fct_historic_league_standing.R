#' Getting historic league standing
#'
#' @description This function returns a mini league's standings over time
#'
#' @param league_number the minileague number you want a table of
#'
#' @export
#'
#' @examples
#' # Getting the expected point for my league in GW1
#' get_league_historic_standings(570437, 1)
#'
#' @importFrom rlang .data
get_league_historic_standings <- function(league_number) {
  # Obtaining league information to get everyone's points
  league <- fplscrapR::get_league_entries(league_number)

  everyones_points <- lapply(league$entry, function(entry_number) {
    entry_points <- fplscrapR::get_entry_season(
      entry_number
    )
  })

  everyones_points <- dplyr::bind_rows(everyones_points)

  # Team names don't come out, so let's put them back
  team_names <- league |>
    dplyr::select(player_name, entry_name)

  everyones_points <- dplyr::left_join(everyones_points,
                                       team_names,
                                       by = c("name" = "player_name"))

  return(everyones_points)
}

get_league_name <- function(league_number) {
  league_name <- fplscrapR::get_league(league_number)
  league_name <- league_name$league$name
}

plot_league_standings <- function(everyones_points, league_name) {
  plotted_data <- everyones_points %>%
    dplyr::select(event, total_points, entry_name)

  overall_rank <- everyones_points %>%
    dplyr::select(event, overall_rank, entry_name)

  league_rank <- lapply(overall_rank$event, function(gw) {
    df <- overall_rank |>
      dplyr::filter(event == gw)
    df <- df[order(df$overall_rank),]
    df$gw_league_rank <- seq(1, nrow(df))
    return(df)
  })
  league_rank <- dplyr::bind_rows(league_rank)
  league_rank$description <- paste0("Gameweek ", league_rank$event)


  ggplot(league_rank, aes(x = event, y = gw_league_rank, color = entry_name)) +
    geom_bump(smooth = 15, size = 2) +
    geom_point(data = league_rank |> filter(event %in% c(min(event), max(event))),
      size = 5) +
    viridis::scale_color_viridis(discrete = TRUE) +
    scale_x_continuous(breaks = league_rank$event %>% unique() %>% sort(),
                       labels = league_rank %>% distinct(event, description) %>% arrange(event) %>% pull(description),
                       expand = expansion(mult = .1)) +
    # geom_text(data = league_rank %>% filter(event == min(event)),
    #           aes(x = event - 0.1, label = entry_name),
    #           size = 5, hjust = 1) +
    geom_text(data = league_rank %>% filter(event == max(event)),
              aes(x = event + 0.1, label = entry_name),
              size = 5, hjust = 0) +
    scale_y_reverse() +
    theme(legend.position = "none",
          panel.grid = element_blank(),
          plot.title = element_text(hjust = .5, color = "white"),
          plot.caption = element_text(hjust = 1, color = "white", size = 8),
          plot.subtitle = element_text(hjust = .5, color = "white", size = 10),
          axis.line = element_blank(),
          axis.ticks = element_blank(),
          axis.text.y = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_text(face = 2, color = "white"),
          panel.background = element_rect(fill = "black"),
          plot.background = element_rect(fill = "black")) +
    labs(x = NULL,
         title = paste0(league_name),
         subtitle = paste0("League standings by gameweek for ", league_name),
         caption = "\nSource: \nFPL API") +
    geom_point(data = tibble(x = 0.55, y = 1:max(league_rank$gw_league_rank)),
               aes(x = x, y = y),
               inherit.aes = F,
               color = "white",
               size = 10,
               pch = 21) +
    geom_text(data = tibble(x = .55, y = 1:max(league_rank$gw_league_rank)),
              aes(x = x, y = y, label = y),
              inherit.aes = F,
              color = "white")



  league_rank  %>%
    ggplot(aes(event, gw_league_rank, color = entry_name, label = entry_name)) +
    geom_line(smooth = 15, size = 2.4) +
    geom_point(
      aes(color = entry_name),
      size = 5,
      pch = 1, # Type of point that allows us to have both color (border) and fill.
      color = "white",
      stroke = 1 # The width of the border, i.e. stroke.
    ) +
    scale_y_reverse() +
    geom_label_repel(
    ) +
    viridis::scale_color_viridis(discrete = TRUE) +
    theme(
      # Set background color to white
      panel.background = element_rect(fill = "white"),
      # Remove all grid lines
      panel.grid = element_blank(),
      # But add grid lines for the vertical axis, customizing color and size
      panel.grid.major.y = element_line(color = "#A8BAC4", size = 0.3),
      # But keep tick marks on horizontal axis
      axis.ticks.length.x = unit(2, "mm"),
      # Remove the title for both axes
      axis.title = element_blank(),
      # Only the bottom line of the vertical axis is painted in black
      axis.line.x.bottom = element_line(color = "black"),
      # But customize labels for the horizontal axis
      axis.text.x = element_text(family = "PremierLeague", size = 16)
    )

  plotted_data %>%
    ggplot2::ggplot(ggplot2::aes(x = event, y = total_points, group = entry_name, color = entry_name)) +
    ggplot2::geom_line() +
    viridis::scale_color_viridis(discrete = TRUE) +
    ggplot2::ggtitle("") +
    hrbrthemes::theme_ipsum() +
    ggplot2::ylab("Total points")

  plotted_data %>%
    ggplot(aes(event, total_points)) +
    geom_line(aes(color = entry_name), size = 2.4) +
    geom_point(
      aes(group = entry_name),
      size = 5,
      pch = 21, # Type of point that allows us to have both color (border) and fill.
      color = "white",
      stroke = 1 # The width of the border, i.e. stroke.
    ) +
    viridis::scale_color_viridis(discrete = TRUE) +
    theme(
      # Set background color to white
      panel.background = element_rect(fill = "white"),
      # Remove all grid lines
      panel.grid = element_blank(),
      # But add grid lines for the vertical axis, customizing color and size
      panel.grid.major.y = element_line(color = "#A8BAC4", size = 0.3),
      # But keep tick marks on horizontal axis
      axis.ticks.length.x = unit(2, "mm"),
      # Remove the title for both axes
      axis.title = element_blank(),
      # Only the bottom line of the vertical axis is painted in black
      axis.line.x.bottom = element_line(color = "black"),
      # But customize labels for the horizontal axis
      axis.text.x = element_text(family = "PremierLeague", size = 16)
    )
}
