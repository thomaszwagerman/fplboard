#' Getting a reactable table theme according to light/darkmode
#'
#' @description This function returns a table of
#' general information for a minileague. Automatically return a
#' table for the current gameweek.
#'
#' @param current_theme the theme is format "dark" or "light"
#'
#' @export
#'
reactable_table_theme <- function(current_theme) {
  if (current_theme() == "dark") {
    reactable::reactableTheme(
      backgroundColor = "#37003c",
      borderColor = "black",
      color = "#00ff88"
      # style = list(
      #   fontFamily = reactablefmtr::google_font("Fira Sans")
      # )
    )
  } else {
    reactable::reactableTheme(
      backgroundColor = "white",
      borderColor = "black",
      color = "#37003c"
      # style = list(
      #   fontFamily = reactablefmtr::google_font("Fira Sans")
      # )
    )
  }
}

#' Getting a gt table theme according to light/darkmode
#'
#' @description This function returns a gt table theme depending on whether
#' the app is in light or dark more
#'
#' @param data the gt table object
#' @param current_theme the theme is format "dark" or "light"
#'
#' @export
#'
gt_table_theme <- function(data, current_theme) {
  if (current_theme() == "dark") {
    data |>
      gt::opt_table_font(
        gt::google_font("Fira Sans")
      ) |>
      gt::tab_options(
        table.background.color = "#37003c",
        table.font.color = "#00ff88"
      )
  } else {
    data |>
      gt::opt_table_font(
        gt::google_font("Fira Sans")
      ) |>
      gt::tab_options(
        table.background.color = "white",
        table.font.color = "#37003c"
      )
  }
}

#' Add pl theme to ggplot chart
#'
#' This function allows you to add the pl theme to ggplot graphics.
#' @keywords pl_style
#' @export
pl_style <- function() {

  ggplot2::theme(

    legend.background = ggplot2::element_blank(),
    legend.title = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),

    axis.title = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_text(margin=ggplot2::margin(5, b = 10)),
    axis.ticks = ggplot2::element_blank(),
    axis.line = ggplot2::element_blank(),

    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(color="#cbcbcb"),
    panel.grid.major.x = ggplot2::element_blank(),

    # Blank background
    # This sets the panel background as blank,
    # removing the standard grey ggplot background colour from the plot
    panel.background = ggplot2::element_blank(),
  )
}

