#' Getting Expected Points for players not owned
#'
#' @description This function players with high expected points
#' not owned by the entrant in a given gameweek.
#'
#' @param entrant_number the entrant number you want a table for
#' @param gameweek the gameweek for expected point
#'
#' @export
#'
#' @examples
#' # Getting the expected point for players not owned by entrant
#' get_ep_not_owned(9680, 1)
#'
#' @importFrom rlang .data
get_ep_not_owned <- function(entrant_number, gameweek) {
  entrant_picks <- get_ep_for_entrant(entrant_number, gameweek)

  # Obtaining all the player information to get their expected points
  df <- fplscrapR::get_player_info() |>
    dplyr::select(.data$team_code, .data$photo,
                  .data$playername, .data$ep_next,
                  .data$value_form, .data$selected_by_percent,
                  .data$transfers_in)

  df$ep_next <- as.numeric(df$ep_next)

  # Adding urls for team logo and player image
  team_logo_url <- "https://resources.premierleague.com/premierleague/badges/70/"
  player_picture_url <- "https://resources.premierleague.com/premierleague/photos/players/110x140/"

  df$team_code <- paste0(team_logo_url, "t", df$team_code, ".png")

  df$photo <- paste0(player_picture_url, "p", df$photo)
  df$photo <- gsub("jpg", "png", df$photo)

  not_owned <- df |>
    dplyr::filter(!.data$playername %in% entrant_picks$playername)

  not_owned <- not_owned[order(
    -not_owned$ep_next
  ), ]

  return(not_owned)
}
