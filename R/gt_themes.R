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
#' @examples
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
