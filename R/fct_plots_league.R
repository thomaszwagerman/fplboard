#' Plotting league standing
#'
#' @description This function plots mini league's standings over time
#'
#' @param league_number the minileague number you want a table of
#'
#' @export
#'
#' @examples
#' # Getting standings for my league across weeks
#' plot_league_standings(570437)
#'
#' @importFrom rlang .data
plot_league_standings <- function(league_number) {
  everyones_points <- get_league_historic_standings(league_number)
  league_name <- get_league_name(league_number)

  overall_rank <- everyones_points |>
    dplyr::select(.data$event, .data$overall_rank, .data$entry_name)

  league_rank <- lapply(overall_rank$event, function(gw) {
    df <- overall_rank |>
      dplyr::filter(.data$event == gw)
    df <- df[order(df$overall_rank), ]
    df$gw_league_rank <- seq(1, nrow(df))
    return(df)
  })

  league_rank <- dplyr::bind_rows(league_rank)
  league_rank$description <- paste0("Gameweek ", league_rank$event)

  ggplot2::ggplot(league_rank, ggplot2::aes(x = .data$event,
                                            y = .data$gw_league_rank,
                                            color = .data$entry_name)) +
    ggplot2::geom_line(size = 2) +
    ggplot2::geom_point(
      data = league_rank |>
        dplyr::filter(.data$event %in% c(min(.data$event), max(.data$event))),
      size = 5
    ) +
    viridis::scale_color_viridis(discrete = TRUE) +
    ggplot2::scale_x_continuous(
      breaks = league_rank$event |>
        unique() |>
        sort(),
      labels = league_rank |>
        dplyr::distinct(.data$event, .data$description) |>
        dplyr::arrange(.data$event) |>
        dplyr::pull(.data$description),
      expand = ggplot2::expansion(mult = .4)
    ) +
    ggplot2::geom_text(
      data = league_rank |>
        dplyr::filter(.data$event == max(.data$event)),
      ggplot2::aes(x = .data$event + 0.1, label = .data$entry_name),
      size = 5, hjust = 0
    ) +
    ggplot2::scale_y_reverse() +
    pl_style() +
    ggplot2::theme(
      legend.position = "none",
      panel.grid.major.y = ggplot2::element_blank(),
      axis.text = ggplot2::element_blank()) +
    # ggplot2::theme(
    #   legend.position = "none",
    #   panel.grid = ggplot2::element_blank(),
    #   plot.title = ggplot2::element_text(hjust = .5,
    #                                      color = "white"),
    #   plot.caption = ggplot2::element_text(hjust = 1,
    #                                        color = "white",
    #                                        size = 8),
    #   plot.subtitle = ggplot2::element_text(hjust = .5,
    #                                         color = "white",
    #                                         size = 10),
  #   axis.line = ggplot2::element_blank(),
  #   axis.ticks = ggplot2::element_blank(),
  #   axis.text.y = ggplot2::element_blank(),
  #   axis.title.y = ggplot2::element_blank(),
  #   axis.text.x = ggplot2::element_text(face = 2, color = "white")
  # ) +
  ggplot2::labs(
    x = NULL,
    title = paste0(league_name),
    subtitle = paste0("League standings by gameweek for ", league_name),
    caption = "\nSource: \nFPL API"
  ) +
    ggplot2::geom_point(
      data = tibble::tibble(x = 0.55, y = 1:max(league_rank$gw_league_rank)),
      ggplot2::aes(x = .data$x, y = .data$y),
      inherit.aes = FALSE,
      color = "black",
      size = 10,
      pch = 21
    ) +
    ggplot2::geom_text(
      data = tibble::tibble(x = .55, y = 1:max(league_rank$gw_league_rank)),
      ggplot2::aes(x = .data$x, y = .data$y, label = .data$y),
      inherit.aes = FALSE,
      color = "black"
    )
}

#' Plotting league points
#'
#' @description This function plots mini league's points over time
#'
#' @param league_number the minileague number you want a table of
#'
#' @export
#'
#' @examples
#' # Getting standings for my league across weeks
#' plot_league_points(570437)
#'
#' @importFrom rlang .data
plot_league_points <- function(league_number) {
  everyones_points <- get_league_historic_standings(league_number)
  league_name <- get_league_name(league_number)

  plotted_data <- everyones_points |>
    dplyr::select(.data$event, .data$total_points, .data$entry_name)

  plotted_data$description <- paste0("Gameweek ", plotted_data$event)

  plotted_data |>
    ggplot2::ggplot(ggplot2::aes(.data$event, .data$total_points)) +
    ggplot2::geom_line(ggplot2::aes(color = .data$entry_name), size = 2.4) +
    ggplot2::geom_point(
      ggplot2::aes(group = .data$entry_name),
      size = 5,
      # Type of point that allows us to have both color (border) and fill.
      pch = 21,
      color = "white",
      stroke = 1 # The width of the border, i.e. stroke.
    ) +
    ggplot2::geom_text(
      data = plotted_data |>
        dplyr::filter(.data$event == max(.data$event)),
      ggplot2::aes(x = .data$event + 0.1, label = .data$entry_name),
      size = 5, hjust = 0
    ) +
    viridis::scale_color_viridis(discrete = TRUE) +
    ggplot2::labs(
      x = NULL,
      title = paste0(league_name),
      subtitle = paste0("League points by gameweek for ", league_name),
      caption = "\nSource: \nFPL API"
    ) +
    pl_style() +
    ggplot2::theme(
      legend.position = "none"
    )
    # ggplot2::theme(
    #   # Set background color to white
    #   panel.background = ggplot2::element_rect(fill = "white"),
    #   # Remove all grid lines
    #   panel.grid = ggplot2::element_blank(),
    #   # But add grid lines for the vertical axis, customizing color and size
    #   panel.grid.major.y = ggplot2::element_line(color = "#A8BAC4", size = 0.3),
    #   # But keep tick marks on horizontal axis
    #   axis.ticks.length.x = ggplot2::unit(2, "mm"),
    #   # Remove the title for both axes
    #   axis.title = ggplot2::element_blank(),
    #   # Only the bottom line of the vertical axis is painted in black
    #   axis.line.x.bottom = ggplot2::element_line(color = "black")
    # )
}
