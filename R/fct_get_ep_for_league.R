#' Getting Expected Points for a league in a given gameweek
#'
#' @description This function returns an expected points table for a minileague
#' in a given gameweek.
#'
#' @param league_number the minileague number you want a table of
#' @param gameweek the gameweek for expected point
#'
#' @export
#'
#' @examples
#' # Getting the expected point for my league in GW1
#' get_ep_for_league(570437, 1)
#'
#' @importFrom rlang .data
get_ep_for_league <- function(league_number, gameweek) {
  # Obtaining league information to get everyone's picks for that gw
  league <- fplscrapR::get_league_entries(league_number)

  everyones_picks <- lapply(league$entry, function(entry_name) {
    entry_picks <- fplscrapR::get_entry_picks(
      entry_name,
      gw = gameweek
    )$picks

    entry_picks$entry <- entry_name

    entry_picks
  })

  everyones_picks <- dplyr::bind_rows(everyones_picks)

  # Combining the entrant information with their picks
  league_entries <- league |>
    dplyr::select("entry", "player_name", "entry"_name)

  league_picks <- dplyr::left_join(league_entries, everyones_picks)

  # Obtaining all the player information to get their expected points
  df <- fplscrapR::get_player_info() |>
    dplyr::select("id", "playername", "ep_next",
                  "value_form", "selected_by_percent") |>
    dplyr::mutate("element" = "id")

  df$ep_next <- as.numeric(df$ep_next)

  # Extract the player information for each entrant, to then create a
  # ranked table
  league_picks <- dplyr::left_join(league_picks, df)

  league_predicted <- league_picks |>
    dplyr::group_by("entry"_name) |>
    dplyr::summarise(expected_points_gw = sum("ep_next"))

  league_predicted <- league_predicted[order(
    -league_predicted$expected_points_gw
  ), ]

  return(league_predicted)
}
