#' Plot players owned throughout gameweeks
#'
#' Plots all of the players an entrant has owned for each gameweek
#'
#' @param entrant_number the team number for your team
#' @param gameweeks the gameweeks you want to plot for
#'
#' @export
#' # Getting players owned for my team across gameweeks
#' plot_players_owned(9680)
#'
#' @importFrom rlang .data
plot_players_owned <- function(entrant_number, gameweeks) {
  entrant_picks <- get_players_owned(entrant_number, gameweeks)

  player_plot <- ggplot2::ggplot(entrant_picks, ggplot2::aes(
    x = gameweek,
    y = reorder(link_to_img(photo), n_gameweeks_owned)
  )) +
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
      axis.text.y = ggtext::element_markdown(
        margin = ggplot2::margin(t = -25, unit = "pt")
      ),
      legend.position = "none",
      panel.grid.major.y = ggplot2::element_blank(),
      axis.text = ggplot2::element_blank()
    ) +
    ggplot2::labs(
      x = NULL,
      title = paste(
        "Players owned GW",
        min(gameweeks),
        "-",
        max(gameweeks),
        "for",
        fplscrapR::get_entry(entrant_number)$name
      ),
      subtitle = paste(
        fplscrapR::get_entry(entrant_number)$name,
        "has owned",
        length(unique(
          entrant_picks$playername
        )),
        "different players!"
      ),
      caption = "\nSource: \nfplscrapR"
    )

  return(player_plot)
}

#' Plot the starting eleven throughout gameweeks
#'
#' Plots all of the players by position for each gameweek
#'
#' @param entrant_number the team number for your team
#' @param gameweeks the gameweeks you want to plot for
#'
#' @export
#' # Getting players owned for my team across gameweeks
#' plot_starting_eleven(9680)
#'
#' @importFrom rlang .data
plot_starting_eleven <- function(entrant_number, gameweeks) {
  entrant_picks <- get_players_owned(entrant_number, gameweeks)

  starting_eleven_plot <- ggplot2::ggplot(entrant_picks, ggplot2::aes(
    x = gameweek,
    y = reorder(position, -position)
  )) +
    # viridis::scale_color_viridis(discrete = TRUE) +
    ggplot2::geom_point() +
    ggimage::geom_image(
      ggplot2::aes(image = photo)
    ) +
    ggplot2::geom_hline(
      ggplot2::aes(yintercept = 4.5, colour = "red")
    )+
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

}
