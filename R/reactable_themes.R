#' Getting a reactable table theme according to light/darkmode
#'
#' @description This function returns a table of
#' general information for a minileague. Automatically return a
#' table for the current gameweek.
#'
#' @param data the reactable table object
#' @param current_theme the theme is format "dark" or "light"
#'
#' @export
#'
#' @examples
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
