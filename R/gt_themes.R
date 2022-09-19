#' Getting a gt table theme according to light/darkmode
#'
#' @description This function returns a table of
#' general information for a minileague. Automatically return a
#' table for the current gameweek.
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
      gt::tab_options(
        table.background.color = "black",
        table.font.color = "white"
      )
  } else {
    data |>
      gt::tab_options(
        table.background.color = "white",
        table.font.color = "black"
      )
  }
}
