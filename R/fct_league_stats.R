#' Getting a table of general information for a minileague's current gw
#'
#' @description This function returns a table of
#' general information for a minileague. Automatically return a
#' table for the current gameweek.
#'
#' @param league_number the league number you want a table for
#'
#' @export
#'
#' @examples
#' # Getting the minileague information
#' get_league_general_info(570437)
#'
#' @importFrom rlang .data
get_league_general_info <- function(league_number) {
  everyones_points <- get_league_historic_standings(league_number)

  everyones_points <- lapply(
    unique(everyones_points$entry_name),
    function(team_name) {
      df <- everyones_points |>
        dplyr::filter(.data$entry_name == team_name)

      x <- diff(df$overall_rank)
      x <- c(0, x)
      df$rank_change <- x
      return(df)
    })

  everyones_points <- dplyr::bind_rows(everyones_points)

  general_information <- everyones_points |>
    dplyr::filter(.data$event == get_current_gw_number()) |>
    dplyr::select(
      .data$entry_name, .data$points,
      .data$total_points, .data$overall_rank,
      .data$rank_change
    ) |>
    dplyr::arrange(dplyr::desc(.data$total_points))
  return(general_information)
}

#' Getting a table of bench points for a minileague
#'
#' @description This function returns a table of
#' bench points for a minileague. Automatically return a
#' table for cumulative amount.
#'
#' @param league_number the league number you want a table for
#'
#' @export
#'
#' @examples
#' # Getting the minileague information
#' get_league_bench_points(570437)
#'
#' @importFrom rlang .data
get_league_bench_points <- function(league_number) {
  everyones_points <- get_league_historic_standings(league_number)

  most_points_on_bench <- everyones_points |>
    dplyr::group_by(.data$entry_name) |>
    dplyr::transmute(bench = sum(.data$points_on_bench)) |>
    unique() |>
    dplyr::arrange(dplyr::desc(.data$bench)) |>
    dplyr::ungroup()

  return(most_points_on_bench)
}

#' Getting a table of team value for a minileague
#'
#' @description This function returns a table of
#' team value for a minileague. Automatically return a
#' table for current gameweek.
#'
#' @param league_number the league number you want a table for
#'
#' @export
#'
#' @examples
#' # Getting the minileague information
#' get_league_team_value(570437)
#'
#' @importFrom rlang .data
get_league_team_value <- function(league_number) {
  everyones_points <- get_league_historic_standings(league_number)

  highest_team_value <- everyones_points |>
    dplyr::filter(.data$event == get_current_gw_number()) |>
    dplyr::select(.data$entry_name, .data$value) |>
    dplyr::arrange(dplyr::desc(.data$value)) |>
    dplyr::ungroup()

  highest_team_value$value <- highest_team_value$value / 10

  return(highest_team_value)
}

#' Getting a table of hits taken for a minileague
#'
#' @description This function returns a table of
#' points deducted for transfers for a minileague. Automatically return a
#' cumulative table.
#'
#' @param league_number the league number you want a table for
#'
#' @export
#'
#' @examples
#' # Getting the minileague information
#' get_league_team_value(570437)
#'
#' @importFrom rlang .data
get_league_hits_taken <- function(league_number) {
  everyones_points <- get_league_historic_standings(league_number)

  most_spent_on_transfers <- everyones_points |>
    dplyr::group_by(.data$entry_name) |>
    dplyr::transmute(transfer_cost = sum(.data$event_transfers_cost)) |>
    unique() |>
    dplyr::arrange(dplyr::desc(.data$transfer_cost)) |>
    dplyr::ungroup()

  return(most_spent_on_transfers)
}
