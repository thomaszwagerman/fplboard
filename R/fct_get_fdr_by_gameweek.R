#' Getting fdr table by gameweek
#'
#' @description This function combines the fixtures and fdr ratings to get
#' a table by gamweek.
#'
#' @examples
#' get_fdr_by_gameweek()
#'
#'
#' @export
#'
#' @importFrom rlang .data
get_fdr_by_gameweek <- function() {
  fdr <- fplscrapR::get_fdr() |>
    dplyr::select(.data$short_name, contains("strength"))

  fixtures <- fplscrapR::get_game_list() |>
    dplyr::filter(.data$GW > get_current_gw_number())

  fixtures <- rbind(
    fixtures |>
      dplyr::mutate(team = .data$home,
                    oppo = .data$away,
                    homeaway = "home"),
    fixtures |>
      dplyr::mutate(team = .data$away,
                    oppo = .data$home,
                    homeaway = "away")
  )  |>
    dplyr::select(
      .data$GW,
      .data$team,
      .data$oppo,
      team_fixture = .data$homeaway
    )

  fixtures$oppo_fixture <- rev(fixtures$team_fixture)

  fdr <- tidyr::pivot_longer(
    fdr,
    cols = contains("strength"),
    names_to = c("category", "opposition_strength"),
    names_pattern = "strength_(.*)_(.*)",
    values_to = "rating",
  ) |>
    dplyr::filter(.data$rating > 999)

  # Join by the opposition and remove home-home, away-away matches
  fdr <- dplyr::left_join(fixtures, fdr, by = c("oppo" = "short_name"))

  # Match the team's fixture to opposition strength
  fdr <- fdr |>
    dplyr::filter(
      opposition_strength == .data$team_fixture &
        .data$team_fixture != .data$oppo_fixture)

  overall <- fdr |>
    dplyr::filter(.data$category == "overall") |>
    dplyr::select(
      .data$GW,
      .data$team,
      .data$oppo,
      .data$team_fixture,
      .data$rating) |>
    tidyr::unite(
      col = "fixture",
      3:4,
      sep = " "
    )

  overall$fixture <- gsub("home", "(H)", overall$fixture)
  overall$fixture <- gsub("away", "(A)", overall$fixture)

  overall[is.na(overall$rating)] <- 0

  table_by_gameweek <- tidyr::pivot_wider(
    overall,
    names_from = "GW",
    values_from = c("fixture", "rating")
  )

  return(table_by_gameweek)
}

#' Getting fdr table by specific gameweeks
#'
#' @description This function combines the fixtures and fdr ratings to get
#' a table by gameweek, and then select specific columns for gameweeks specified.
#' If you want the table to be update according to user intput, these shuld be reactive
#'
#' @examples
#'gw_columns <- paste0(
#'  "fixture_",
#'  c(30:35)
#')
#'  rating_columns <- paste0(
#'    "rating_",
#'    c(30:35)
#'  )
#'
#' get_fdr_for_selected_gameweek()
#'
#'
#' @export
#'
#' @importFrom rlang .data
# Create a reactive table with the gameweek and rating columns needed
get_fdr_for_selected_gameweek <- function(input_gw) {
    gw_columns <- paste0(
      "fixture_",
      c(min(input_gw):max(input_gw))
    )

    rating_columns <- paste0(
      "rating_",
      c(min(input_gw):max(input_gw))
    )

  totals <- get_fdr_by_gameweek() |>
    dplyr::select(
      .data$team,
      dplyr::all_of(rating_columns)
    ) |>
    tidyr::pivot_longer(
      cols = rating_columns,
      names_to = "gw",
      values_to = "rating"
    )

  avgs <- totals |>
    dplyr::group_by(.data$team) |>
    dplyr::filter(.data$rating > 0) |>
    dplyr::summarise(
      average_fdr = sum(.data$rating, na.rm = TRUE) / length(.data$rating)
    )

  avgs$average_fdr <- as.integer(avgs$average_fdr)

  # Joining the totals, so  table can be sorted for selected GWs
  table_by_gameweek <- dplyr::left_join(get_fdr_by_gameweek(), avgs)

  table_df <- table_by_gameweek |>
    dplyr::select(
      .data$team,
      dplyr::all_of(gw_columns),
      .data$average_fdr,
      dplyr::all_of(rating_columns))
}
