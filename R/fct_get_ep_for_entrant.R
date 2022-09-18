#' Getting Expected Points for a entrant in a given gameweek
#'
#' @description This function returns expected points for an entrant
#' in a given gameweek.
#'
#' @param entrant_number the entrant number you want a table for
#' @param gameweek the gameweek for expected point
#'
#' @export
#'
#' @examples
#' # Getting the expected point for my team in GW1
#' get_ep_for_league(9680, 1)
#'
#' @importFrom rlang .data
get_ep_for_entrant <- function(entrant_number, gameweek) {
  my_picks <- fplscrapR::get_entry_picks(entrant_number, gameweek)$picks

  # Obtaining all the player information to get their expected points
  df <- fplscrapR::get_player_info() |>
    dplyr::select(.data$id, .data$team_code,
                  .data$photo, .data$playername,
                  .data$ep_next, .data$value_form,
                  .data$selected_by_percent) |>
    dplyr::mutate("element" = .data$id)

  df$ep_next <- as.numeric(df$ep_next)

  # Extract the player information for each entrant, to then create a
  # ranked table
  entrant_picks <- dplyr::left_join(my_picks, df) |>
    dplyr::select(.data$position, .data$is_captain,
                  .data$is_vice_captain,
                  .data$team_code, .data$photo,
                  .data$playername, .data$ep_next,
                  .data$value_form, .data$selected_by_percent)

  # Adding urls for team logo and player image
  team_logo_url <- "https://resources.premierleague.com/premierleague/badges/70/"
  player_picture_url <- "https://resources.premierleague.com/premierleague/photos/players/110x140/"

  entrant_picks$team_code <- paste0(team_logo_url, "t", entrant_picks$team_code, ".png")

  entrant_picks$photo <- paste0(player_picture_url, "p", entrant_picks$photo)
  entrant_picks$photo <- gsub("jpg", "png", entrant_picks$photo)

  return(entrant_picks)
}
