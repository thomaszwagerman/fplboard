#' Get players owned
#'
#' Fetches the players the entrant owned for given gameweeks. This can then
#' be fed into a plot of players owned, or starting 11 throughout the weeks.
#'
#' @param entrant_number the entrant number you want a table for
#' @param gameweeks gameweeks data should be fetched for
#'
#' @export
#'
#' @examples
#' # Getting the expected point for my team in GW1
#' get_players_owned(9680, 1)
#'
#' # Getting the expected points for my team GW 1-16
#' get_players_owned(9680, c(1:16))
#'
#' @importFrom rlang .data
get_players_owned <- function(entrant_number, gameweeks) {
  entrant_picks <- lapply(gameweeks, function(gameweek) {
    gw_picks <- fplscrapR::get_entry_picks(entrant_number, gameweek)$picks
    gw_picks$gameweek <- as.numeric(gameweek)
    return(gw_picks)
  })

  entrant_picks <- dplyr::bind_rows(entrant_picks)

  # Obtaining all the player to link to ownership over all gameweeks
  df <- fplscrapR::get_player_info() |>
    dplyr::select(
      .data$id, .data$team_code,
      .data$photo, .data$playername
    ) |>
    dplyr::mutate("element" = .data$id)

  # Join player information to the entrant picks
  entrant_picks <- dplyr::left_join(entrant_picks, df, by = "element") |>
    dplyr::select(
      .data$position, .data$is_captain,
      .data$is_vice_captain, .data$position,
      .data$team_code, .data$photo,
      .data$playername, .data$gameweek
    )

  # Adding urls for team logo and player image
  team_logo_url <- "https://resources.premierleague.com/premierleague/badges/70/"
  player_picture_url <- "https://resources.premierleague.com/premierleague/photos/players/110x140/"

  entrant_picks$team_code <- paste0(
    team_logo_url, "t", entrant_picks$team_code, ".png"
  )

  entrant_picks$photo <- paste0(player_picture_url, "p", entrant_picks$photo)
  entrant_picks$photo <- gsub("jpg", "png", entrant_picks$photo)

  owned_count <- entrant_picks |>
    dplyr::group_by(.data$playername) |>
    dplyr::count()

  colnames(owned_count) <- c("playername", "n_gameweeks_owned")

  entrant_picks <- dplyr::left_join(
    entrant_picks, owned_count, by = "playername"
  )

  return(entrant_picks)
}
