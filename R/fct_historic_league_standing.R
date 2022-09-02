#' Getting historic league standing
#'
#' @description This function returns a mini league's standings over time
#'
#' @param league_number the minileague number you want a table of
#'
#' @export
#'
#' @examples
#' # Getting standings for my league across weeks
#' get_league_historic_standings(570437)
#'
#' @importFrom rlang .data
get_league_historic_standings <- function(league_number) {
  # Obtaining league information to get everyone's points
  league <- fplscrapR::get_league_entries(league_number)

  everyones_points <- lapply(league$entry, function(entry_number) {
    fplscrapR::get_entry_season(
      entry_number
    )
  })

  everyones_points <- dplyr::bind_rows(everyones_points)

  # Team names don't come out, so let's put them back
  team_names <- league |>
    dplyr::select(.data$player_name, .data$entry_name)

  everyones_points <- dplyr::left_join(everyones_points,
                                       team_names,
                                       by = c("name" = "player_name")
  )

  return(everyones_points)
}

#' Getting league name
#'
#' @description This function returns the league name in character format
#'
#' @param league_number the minileague number you want the name of
#'
#' @export
#'
#' @examples
#' # Getting the league name for my league
#' get_league_name(570437)
#'
#' @importFrom rlang .data
get_league_name <- function(league_number) {
  league_name <- fplscrapR::get_league(league_number)
  league_name <- league_name$league$name
  return(league_name)
}
